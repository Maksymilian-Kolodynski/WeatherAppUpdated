import Foundation

class ApiClientService {
  static let shared = ApiClientService()

  private init() {}

  // This shouldn't be here!
  private let API_KEY = "0edb0d5e067a467f889161628241503"

  private let baseUrl = "https://api.weatherapi.com/v1/"

  func fetchData(endpoint: String, city: String) async -> FutureForecastModel? {
    guard let url = URL(string: "\(baseUrl)\(endpoint).json?lang=pl&key=\(API_KEY)&q=\(city)&days=14") else {
      print("⚠️", "Can't parse url!", "⚠️")
      return nil
    }

    do {
      let (data, _) = try await URLSession.shared.data(from: url)

      // TODO: Handle API errors!

      let decodedModel = try JSONDecoder().decode(FutureForecastModel.self, from: data)
      return decodedModel
    } catch {
      print("⚠️", "Fetching or decoding data failed!", "⚠️")
      print("⚠️", error, "⚠️")
      return nil
    }
  }
}
