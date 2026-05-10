//
//  LocalStorageManager.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 23.04.2026.
//


import Foundation

final class LocalStorageManager {
    static let shared = LocalStorageManager()

    private init() {}

    private let favoritesKey = "favorite_vehicles"
    private let reservationsKey = "stored_reservations"

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    func saveFavorite(_ vehicle: Vehicle) {
        var items = fetchFavorites()

        if !items.contains(where: { $0.id == vehicle.id }) {
            items.append(vehicle)
            save(items, forKey: favoritesKey)
        }
    }

    func removeFavorite(vehicleId: Int) {
        var items = fetchFavorites()
        items.removeAll { $0.id == vehicleId }
        save(items, forKey: favoritesKey)
    }
    
    func removeReservation(trackingCode: String) {
        var items = fetchReservations()
        items.removeAll { $0.trackingCode == trackingCode }
        save(items, forKey: reservationsKey)
    }

    func isFavorite(vehicleId: Int) -> Bool {
        fetchFavorites().contains(where: { $0.id == vehicleId })
    }

    func fetchFavorites() -> [Vehicle] {
        fetch([Vehicle].self, forKey: favoritesKey) ?? []
    }

    func saveReservation(_ reservation: StoredReservation) {
        var items = fetchReservations()

        if !items.contains(where: { $0.trackingCode == reservation.trackingCode }) {
            items.insert(reservation, at: 0)
            save(items, forKey: reservationsKey)
        }
    }

    func fetchReservations() -> [StoredReservation] {
        fetch([StoredReservation].self, forKey: reservationsKey) ?? []
    }

    private func save<T: Codable>(_ value: T, forKey key: String) {
        guard let data = try? encoder.encode(value) else { return }
        UserDefaults.standard.set(data, forKey: key)
    }

    private func fetch<T: Codable>(_ type: T.Type, forKey key: String) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        return try? decoder.decode(type, from: data)
    }
}
