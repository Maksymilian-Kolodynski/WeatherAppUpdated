struct FutureForecastModel: Decodable {
  let forecast: ForecastDayWrapperModel
}

struct ForecastDayWrapperModel: Decodable {
  let forecastDay: [ForecastDayModel]

  enum CodingKeys: String, CodingKey {
    case forecastDay = "forecastday"
  }
}

struct ForecastDayModel: Decodable, Identifiable {
  var id: String {
    date
  }

  let date: String
  let day: ForecastDaySingleModel
}

struct ForecastDaySingleModel: Decodable {
  let avgTempC: Double
  let condition: ConditionModel

  enum CodingKeys: String, CodingKey {
    case avgTempC = "avgtemp_c"
    case condition
  }
}

struct ConditionModel: Decodable {
  let text: String
  let icon: String
}
