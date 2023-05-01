// To parse this JSON data, do
//
//     final weatherModel = weatherModelFromJson(jsonString);

import 'dart:convert';

WeatherModel weatherModelFromJson(String str) => WeatherModel.fromJson(json.decode(str));

String weatherModelToJson(WeatherModel data) => json.encode(data.toJson());

class WeatherModel {
    double? lat;
    double? lon;
    String? timezone;
    int? timezoneOffset;
    Current? current;
    List<Current>? hourly;
    List<Daily>? daily;

    WeatherModel({
        this.lat,
        this.lon,
        this.timezone,
        this.timezoneOffset,
        this.current,
        this.hourly,
        this.daily,
    });

    WeatherModel copyWith({
        double? lat,
        double? lon,
        String? timezone,
        int? timezoneOffset,
        Current? current,
        List<Current>? hourly,
        List<Daily>? daily,
    }) => 
        WeatherModel(
            lat: lat ?? this.lat,
            lon: lon ?? this.lon,
            timezone: timezone ?? this.timezone,
            timezoneOffset: timezoneOffset ?? this.timezoneOffset,
            current: current ?? this.current,
            hourly: hourly ?? this.hourly,
            daily: daily ?? this.daily,
        );

    factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        timezone: json["timezone"],
        timezoneOffset: json["timezone_offset"],
        current: json["current"] == null ? null : Current.fromJson(json["current"]),
        hourly: json["hourly"] == null ? [] : List<Current>.from(json["hourly"]!.map((x) => Current.fromJson(x))),
        daily: json["daily"] == null ? [] : List<Daily>.from(json["daily"]!.map((x) => Daily.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
        "timezone": timezone,
        "timezone_offset": timezoneOffset,
        "current": current?.toJson(),
        "hourly": hourly == null ? [] : List<dynamic>.from(hourly!.map((x) => x.toJson())),
        "daily": daily == null ? [] : List<dynamic>.from(daily!.map((x) => x.toJson())),
    };
}

class Current {
    int? dt;
    int? sunrise;
    int? sunset;
    double? temp;
    double? feelsLike;
    int? pressure;
    int? humidity;
    double? dewPoint;
    double? uvi;
    int? clouds;
    int? visibility;
    double? windSpeed;
    int? windDeg;
    double? windGust;
    List<Weather>? weather;
    double? pop;
    Rain? rain;

    Current({
        this.dt,
        this.sunrise,
        this.sunset,
        this.temp,
        this.feelsLike,
        this.pressure,
        this.humidity,
        this.dewPoint,
        this.uvi,
        this.clouds,
        this.visibility,
        this.windSpeed,
        this.windDeg,
        this.windGust,
        this.weather,
        this.pop,
        this.rain,
    });

    Current copyWith({
        int? dt,
        int? sunrise,
        int? sunset,
        double? temp,
        double? feelsLike,
        int? pressure,
        int? humidity,
        double? dewPoint,
        double? uvi,
        int? clouds,
        int? visibility,
        double? windSpeed,
        int? windDeg,
        double? windGust,
        List<Weather>? weather,
        double? pop,
        Rain? rain,
    }) => 
        Current(
            dt: dt ?? this.dt,
            sunrise: sunrise ?? this.sunrise,
            sunset: sunset ?? this.sunset,
            temp: temp ?? this.temp,
            feelsLike: feelsLike ?? this.feelsLike,
            pressure: pressure ?? this.pressure,
            humidity: humidity ?? this.humidity,
            dewPoint: dewPoint ?? this.dewPoint,
            uvi: uvi ?? this.uvi,
            clouds: clouds ?? this.clouds,
            visibility: visibility ?? this.visibility,
            windSpeed: windSpeed ?? this.windSpeed,
            windDeg: windDeg ?? this.windDeg,
            windGust: windGust ?? this.windGust,
            weather: weather ?? this.weather,
            pop: pop ?? this.pop,
            rain: rain ?? this.rain,
        );

    factory Current.fromJson(Map<String, dynamic> json) => Current(
        dt: json["dt"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        temp: json["temp"]?.toDouble(),
        feelsLike: json["feels_like"]?.toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
        dewPoint: json["dew_point"]?.toDouble(),
        uvi: json["uvi"]?.toDouble(),
        clouds: json["clouds"],
        visibility: json["visibility"],
        windSpeed: json["wind_speed"]?.toDouble(),
        windDeg: json["wind_deg"],
        windGust: json["wind_gust"]?.toDouble(),
        weather: json["weather"] == null ? [] : List<Weather>.from(json["weather"]!.map((x) => Weather.fromJson(x))),
        pop: json["pop"]?.toDouble(),
        rain: json["rain"] == null ? null : Rain.fromJson(json["rain"]),
    );

    Map<String, dynamic> toJson() => {
        "dt": dt,
        "sunrise": sunrise,
        "sunset": sunset,
        "temp": temp,
        "feels_like": feelsLike,
        "pressure": pressure,
        "humidity": humidity,
        "dew_point": dewPoint,
        "uvi": uvi,
        "clouds": clouds,
        "visibility": visibility,
        "wind_speed": windSpeed,
        "wind_deg": windDeg,
        "wind_gust": windGust,
        "weather": weather == null ? [] : List<dynamic>.from(weather!.map((x) => x.toJson())),
        "pop": pop,
        "rain": rain?.toJson(),
    };
}

class Rain {
    double? the1H;

    Rain({
        this.the1H,
    });

    Rain copyWith({
        double? the1H,
    }) => 
        Rain(
            the1H: the1H ?? this.the1H,
        );

    factory Rain.fromJson(Map<String, dynamic> json) => Rain(
        the1H: json["1h"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "1h": the1H,
    };
}

class Weather {
    int? id;
    Main? main;
    String? description;
    String? icon;

    Weather({
        this.id,
        this.main,
        this.description,
        this.icon,
    });

    Weather copyWith({
        int? id,
        Main? main,
        String? description,
        String? icon,
    }) => 
        Weather(
            id: id ?? this.id,
            main: main ?? this.main,
            description: description ?? this.description,
            icon: icon ?? this.icon,
        );

    factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: mainValues.map[json["main"]]!,
        description: json["description"],
        icon: json["icon"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "main": mainValues.reverse[main],
        "description": description,
        "icon": icon,
    };
}

enum Main { CLEAR, CLOUDS, RAIN }

final mainValues = EnumValues({
    "Clear": Main.CLEAR,
    "Clouds": Main.CLOUDS,
    "Rain": Main.RAIN
});

class Daily {
    int? dt;
    int? sunrise;
    int? sunset;
    int? moonrise;
    int? moonset;
    double? moonPhase;
    Temp? temp;
    FeelsLike? feelsLike;
    int? pressure;
    int? humidity;
    double? dewPoint;
    double? windSpeed;
    int? windDeg;
    double? windGust;
    List<Weather>? weather;
    int? clouds;
    double? pop;
    double? uvi;
    double? rain;

    Daily({
        this.dt,
        this.sunrise,
        this.sunset,
        this.moonrise,
        this.moonset,
        this.moonPhase,
        this.temp,
        this.feelsLike,
        this.pressure,
        this.humidity,
        this.dewPoint,
        this.windSpeed,
        this.windDeg,
        this.windGust,
        this.weather,
        this.clouds,
        this.pop,
        this.uvi,
        this.rain,
    });

    Daily copyWith({
        int? dt,
        int? sunrise,
        int? sunset,
        int? moonrise,
        int? moonset,
        double? moonPhase,
        Temp? temp,
        FeelsLike? feelsLike,
        int? pressure,
        int? humidity,
        double? dewPoint,
        double? windSpeed,
        int? windDeg,
        double? windGust,
        List<Weather>? weather,
        int? clouds,
        double? pop,
        double? uvi,
        double? rain,
    }) => 
        Daily(
            dt: dt ?? this.dt,
            sunrise: sunrise ?? this.sunrise,
            sunset: sunset ?? this.sunset,
            moonrise: moonrise ?? this.moonrise,
            moonset: moonset ?? this.moonset,
            moonPhase: moonPhase ?? this.moonPhase,
            temp: temp ?? this.temp,
            feelsLike: feelsLike ?? this.feelsLike,
            pressure: pressure ?? this.pressure,
            humidity: humidity ?? this.humidity,
            dewPoint: dewPoint ?? this.dewPoint,
            windSpeed: windSpeed ?? this.windSpeed,
            windDeg: windDeg ?? this.windDeg,
            windGust: windGust ?? this.windGust,
            weather: weather ?? this.weather,
            clouds: clouds ?? this.clouds,
            pop: pop ?? this.pop,
            uvi: uvi ?? this.uvi,
            rain: rain ?? this.rain,
        );

    factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        dt: json["dt"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        moonrise: json["moonrise"],
        moonset: json["moonset"],
        moonPhase: json["moon_phase"]?.toDouble(),
        temp: json["temp"] == null ? null : Temp.fromJson(json["temp"]),
        feelsLike: json["feels_like"] == null ? null : FeelsLike.fromJson(json["feels_like"]),
        pressure: json["pressure"],
        humidity: json["humidity"],
        dewPoint: json["dew_point"]?.toDouble(),
        windSpeed: json["wind_speed"]?.toDouble(),
        windDeg: json["wind_deg"],
        windGust: json["wind_gust"]?.toDouble(),
        weather: json["weather"] == null ? [] : List<Weather>.from(json["weather"]!.map((x) => Weather.fromJson(x))),
        clouds: json["clouds"],
        pop: json["pop"]?.toDouble(),
        uvi: json["uvi"]?.toDouble(),
        rain: json["rain"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "dt": dt,
        "sunrise": sunrise,
        "sunset": sunset,
        "moonrise": moonrise,
        "moonset": moonset,
        "moon_phase": moonPhase,
        "temp": temp?.toJson(),
        "feels_like": feelsLike?.toJson(),
        "pressure": pressure,
        "humidity": humidity,
        "dew_point": dewPoint,
        "wind_speed": windSpeed,
        "wind_deg": windDeg,
        "wind_gust": windGust,
        "weather": weather == null ? [] : List<dynamic>.from(weather!.map((x) => x.toJson())),
        "clouds": clouds,
        "pop": pop,
        "uvi": uvi,
        "rain": rain,
    };
}

class FeelsLike {
    double? day;
    double? night;
    double? eve;
    double? morn;

    FeelsLike({
        this.day,
        this.night,
        this.eve,
        this.morn,
    });

    FeelsLike copyWith({
        double? day,
        double? night,
        double? eve,
        double? morn,
    }) => 
        FeelsLike(
            day: day ?? this.day,
            night: night ?? this.night,
            eve: eve ?? this.eve,
            morn: morn ?? this.morn,
        );

    factory FeelsLike.fromJson(Map<String, dynamic> json) => FeelsLike(
        day: json["day"]?.toDouble(),
        night: json["night"]?.toDouble(),
        eve: json["eve"]?.toDouble(),
        morn: json["morn"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "day": day,
        "night": night,
        "eve": eve,
        "morn": morn,
    };
}

class Temp {
    double? day;
    double? min;
    double? max;
    double? night;
    double? eve;
    double? morn;

    Temp({
        this.day,
        this.min,
        this.max,
        this.night,
        this.eve,
        this.morn,
    });

    Temp copyWith({
        double? day,
        double? min,
        double? max,
        double? night,
        double? eve,
        double? morn,
    }) => 
        Temp(
            day: day ?? this.day,
            min: min ?? this.min,
            max: max ?? this.max,
            night: night ?? this.night,
            eve: eve ?? this.eve,
            morn: morn ?? this.morn,
        );

    factory Temp.fromJson(Map<String, dynamic> json) => Temp(
        day: json["day"]?.toDouble(),
        min: json["min"]?.toDouble(),
        max: json["max"]?.toDouble(),
        night: json["night"]?.toDouble(),
        eve: json["eve"]?.toDouble(),
        morn: json["morn"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "day": day,
        "min": min,
        "max": max,
        "night": night,
        "eve": eve,
        "morn": morn,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}