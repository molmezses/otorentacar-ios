//
//  BookingQueryViewModel.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import Foundation
import Combine

@MainActor
final class BookingQueryViewModel: ObservableObject {
    @Published var bookingCode: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var foundReservation: Reservation?
    @Published var navigateToDetail: Bool = false
    
    private let reservationService: ReservationServiceProtocol
    
    init(reservationService: ReservationServiceProtocol) {
        self.reservationService = reservationService
    }
    
    convenience init() {
        self.init(reservationService: MockReservationService())
    }
    
    func queryReservation() {
        let trimmedCode = bookingCode.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedCode.isEmpty else {
            errorMessage = "Lütfen rezervasyon kodunu girin."
            return
        }
        
        Task {
            await fetchReservation(with: trimmedCode)
        }
    }
    
    func fetchReservation(with code: String) async {
        isLoading = true
        errorMessage = nil
        foundReservation = nil
        navigateToDetail = false
        
        do {
            let reservation = try await reservationService.fetchReservation(by: code)
            foundReservation = reservation
            navigateToDetail = true
        } catch {
            errorMessage = "Rezervasyon bulunamadı. Lütfen kodu kontrol edip tekrar deneyin."
        }
        
        isLoading = false
    }
}
