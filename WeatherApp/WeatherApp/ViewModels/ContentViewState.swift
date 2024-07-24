import SwiftUI

@MainActor
class ContentViewState: ObservableObject {
  @Published var model: FutureForecastModel?

  @Published var isLoading = false
  @Published var isError = false

  func fetchData(endpoint: String, city: String) async {
    isLoading = true
    model = await ApiClientService.shared.fetchData(endpoint: endpoint, city: city)
    isLoading = false
    if model == nil {
      isError = true
    }
  }
}
