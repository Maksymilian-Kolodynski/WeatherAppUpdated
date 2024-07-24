import SwiftUI

struct ContentView: View {
  @ObservedObject var state = ContentViewState()

  var body: some View {
    NavigationStack {
      VStack {
        HStack(spacing: 4) {
          Image(systemName: "cloud")
            .imageScale(.large)
            .foregroundStyle(.tint)
          Text("Weather App")
        }

        Spacer().frame(height: 20)

        if state.isLoading {
          ProgressView()
        } else if state.isError {
          Text("Some API error")
        } else if let forecastDayModel = state.model?.forecast.forecastDay {
          List(forecastDayModel) { item in
            NavigationLink("\(item.date)") {
              ForecastDetailView(item: item)
            }
          }
          .listStyle(.plain)
        }
      }
      .padding()
    }
    .task {
      await state.fetchData(endpoint: "forecast", city: "Gliwice")
    }
  }
}

private struct ForecastDetailView: View {
  let item: ForecastDayModel

  var body: some View {
    VStack {
      Text(getWeekdayName)
        .fontWeight(Font.Weight.bold)
        .padding(.bottom, 10)

      Text("Actual temp: \(String(format: "%.1f", item.day.avgTempC)) ℃")
        .padding(.bottom, 10)

      VStack {
        Text("\(item.day.condition.text): ")
          .padding(.trailing, 4)

        AsyncImage(url: URL(string: "https:\(item.day.condition.icon)")) { image in
          image
            .resizable()
            .frame(width: 50, height: 50)
            .padding(.bottom, 10)
        } placeholder: {
          ProgressView()
            .frame(width: 50, height: 50)
        }
      }

      Spacer()
    }
  }

  private var getWeekdayName: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    if let date = dateFormatter.date(from: item.date) {
      let weekdayIndex = Calendar.current.component(.weekday, from: date)
      dateFormatter.dateFormat = "EEEE"
      return dateFormatter.string(from: date)
    }
    return item.date
  }
}
