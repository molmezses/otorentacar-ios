//
//  SearchReservationAPIService.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 17.04.2026.
//


import Foundation

final class SearchReservationAPIService: ReservationServiceProtocol {
    
    private let tokenStore: TokenStoreProtocol
    
    private let priceSearchService: PriceSearchServiceProtocol
    
    init(
        tokenStore: TokenStoreProtocol = InMemoryTokenStore.shared,
        priceSearchService: PriceSearchServiceProtocol = PriceSearchAPIService()
    ) {
        self.tokenStore = tokenStore
        self.priceSearchService = priceSearchService
    }
    
    func fetchReservation(by code: String) async throws -> Reservation {
        guard let token = tokenStore.fetchToken(), !token.isEmpty else {
            throw URLError(.userAuthenticationRequired)
        }
        
        let url = URL(string: AppConfig.baseURL + "/ws/rentacar/v1/tr/searchReservation")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = FormURLEncoder.encode([
            "token": token,
            "reservationCode": code
        ])
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        let decoded = try JSONDecoder().decode(SearchReservationResponse.self, from: data)

        guard decoded.status == 1, let dto = decoded.data?.object else {
            throw NSError(
                domain: "SearchReservationAPIService",
                code: decoded.status,
                userInfo: [
                    NSLocalizedDescriptionKey: decoded.description ?? "Rezervasyon bulunamadı."
                ]
            )
        }

        var reservation = dto.toDomain()

        if let token = tokenStore.fetchToken(),
           let _ = dto.vehicleModel?.modelId,
           let pickUpLocationPointId = dto.pickUpLocationPoint?.id,
           let dropOffLocationPointId = dto.dropOffLocationPoint?.id,
           let pickUpDateTime = dto.pickUpDateTime,
           let dropOffDateTime = dto.dropOffDateTime {

            let priceRequest = PriceSearchRequest(
                token: token,
                pickUpDateTime: convertReservationDateTimeToAPIFormat(pickUpDateTime),
                dropOffDateTime: convertReservationDateTimeToAPIFormat(dropOffDateTime),
                pickUpLocationPointId: pickUpLocationPointId,
                dropOffLocationPointId: dropOffLocationPointId
            )

            if let matchedVehicle = try? await priceSearchService.searchPrices(request: priceRequest).first {
                let rentalDayCount = FormatterHelper.rentalDayCount(
                    pickUpDate: reservation.pickUpDate,
                    pickUpTime: reservation.pickUpDate,
                    dropOffDate: reservation.dropOffDate,
                    dropOffTime: reservation.dropOffDate
                )

                let enrichedVehicle = matchedVehicle.toDomain(rentalDayCount: rentalDayCount)

                reservation = Reservation(
                    id: reservation.id,
                    trackingCode: reservation.trackingCode,
                    vehicle: Vehicle(
                        id: reservation.vehicle.id,
                        name: reservation.vehicle.name,
                        brand: reservation.vehicle.brand,
                        segment: reservation.vehicle.segment,
                        transmission: reservation.vehicle.transmission,
                        fuelType: reservation.vehicle.fuelType,
                        passengerCount: reservation.vehicle.passengerCount,
                        baggageCount: reservation.vehicle.baggageCount,
                        dailyPrice: reservation.vehicle.dailyPrice,
                        totalPrice: reservation.vehicle.totalPrice,
                        imageURL: enrichedVehicle.imageURL,
                        badge: reservation.vehicle.badge,
                        isFavorite: reservation.vehicle.isFavorite,
                        currencyId: reservation.vehicle.currencyId,
                        currencyCode: reservation.vehicle.currencyCode
                    ),
                    pickUpLocation: reservation.pickUpLocation,
                    dropOffLocation: reservation.dropOffLocation,
                    pickUpDate: reservation.pickUpDate,
                    dropOffDate: reservation.dropOffDate,
                    totalAmount: reservation.totalAmount,
                    status: reservation.status,
                    extras: reservation.extras,
                    fullName: reservation.fullName,
                    email: reservation.email,
                    phone: reservation.phone,
                    birthDate: reservation.birthDate,
                    pickUpLocationPointId: reservation.pickUpLocationPointId,
                    dropOffLocationPointId: reservation.dropOffLocationPointId
                )
            }
        }

        return reservation
    }
    
    private func convertReservationDateTimeToAPIFormat(_ value: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let outputFormatter = DateFormatter()
        outputFormatter.locale = Locale(identifier: "tr_TR")
        outputFormatter.dateFormat = "dd.MM.yyyy HH:mm"

        if let date = inputFormatter.date(from: value) {
            return outputFormatter.string(from: date)
        }

        return value
    }
}
