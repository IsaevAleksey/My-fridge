import Foundation

struct OpenFoodFactsProduct: Decodable {
    let product_name: String?
    let brands: String?
    let image_url: String?
    let image_front_url: String?
}

struct OpenFoodFactsResponse: Decodable {
    let status: Int
    let product: OpenFoodFactsProduct?
}

final class OpenFoodFactsService {
    static let shared = OpenFoodFactsService()
    private init() {}
    
    func fetchProduct(barcode: String) async throws -> OpenFoodFactsProduct? {
        guard let url = URL(string: "https://world.openfoodfacts.org/api/v2/product/\(barcode).json") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let response = try decoder.decode(OpenFoodFactsResponse.self, from: data)
        if response.status == 1 {
            return response.product
        } else {
            return nil
        }
    }
} 