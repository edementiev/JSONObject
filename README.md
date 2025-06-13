# JSONObject

1.0.0
- Первая версия

1.0.1
- Поддержка iSO/tvOS 15, MacOS 12

1.1.0
- Флаг errorLogging стал public
- Флаг isInitialied показывает были ли ошибки в конструкторе (например init(data: Data?) пришел nil или битый JSON)

1.1.1
- Если мы ждем строку, то что бы мы не получили будет строка

1.1.2
- Фикс предыдущего релиза 

1.5
- Новые нициализаторы init(dict: [String: Any]) и init(json: JSONObject)

2.0
- Сделано преобразование Double -> Int, Double(as String) -> Int как целочисленные, так и с отбрасыванием десятичных
- Сделаны тесты на все типа преобразования

2.1
- Добавлен метод arrayObjects(key: String) -> [JSONObject]

2.3
- Using Sendable struct instead of class
