import Foundation



// -----------------------------------------------
// MARK: - Простые задачи
// -----------------------------------------------


// =================================
// MARK: - Task 1
// =================================
/*
 1. Объявите опциональную переменную типа Int.

 2. Подкиньте монетку (Bool.random()). Если значение монетки true, то присвойте переменной любое число.
    В противном случае оставьте опционал пустым.

 3. Воспользовавшись optional binding, разверните переменную и выведите в консоль её значение.
    Если не удалось развернуть, то выведите в консоль случайное число от 1 до 100 */


// -----------------------------------------------
// MARK: - Task 1. Solution
// -----------------------------------------------

var optionalInt: Int?
if Bool.random() {
    optionalInt = Int.random(in: 101...10000)
}

if let item: Int = optionalInt {
    print(item)
} else {
    print(Int.random(in: 1...100))
}



// =================================
// MARK: - Task 2
// =================================
/*
 1. Создайте перечисление вещей, которые вас вдохновляют.

 2. Выведите все вещи в консоль с помощью CaseIterable.

 3. Напишите switch case по перечислению вдохновляющих вещей (для этого понадобится создать какую-то одну вещь).
    В каждом case выведите в консоль сообщение с объяснением, почему именно это вас вдохновляет.

 4. Объедините несколько case через запятую

 5. Реализуйте кейс по умолчанию для тех вещей, которые не хочется объяснять.*/


// -----------------------------------------------
// MARK: - Task 2. Solution
// -----------------------------------------------

enum ThingsForMy {
    case auto
    case motorcycle
    case family
    case hoping
    case education
    case love
    case work
    case child
}

let myThing: ThingsForMy = .family

switch myThing {
case .auto:
    print("Удобство и комфорт")
case .motorcycle:
    print("Скорость и адреналин")
case .family, .child, .love:
    print("То, ради чего стоит жить")
default:
    print("Не хочется объяснять")
}


// =================================
// MARK: - Task 3
// =================================
/*
 1. Игрок стреляет в мишень. Каждый выстрел состоит из номера попытки, сообщения "SHOT!" и результата (от 0 до 10 очков).

 2. Напишите программу, которая делает 10 выстрелов и находит общее количество выбитых очков

 3. Очки за выстрел начисляются следующим образом:
    • если игрок промахнулся (0), то в консоль выводится сообщение о промахе и от общего результата отнимается 1 штрафной балл.
    • если игрок попал в сектор от 1 до 5 и это нечетный выстрел, то результат выстрела увеличивается на 20%
    • если игрок попал в сектор от 6 до 10 и это четный выстрел, то результат выстрела увеличивается на 30%
    • если это 7 попытка, то у игрока отнимается 1 балл от общего результата
    • во всех остальных случаях количество очков за выстрел остаётся неизменным

 4. В каждом условии выведите в консоль номер выстрела, сообщение, очки за выстрел и общий результат. */




// -----------------------------------------------
// MARK: - Task 3. Solution
// -----------------------------------------------

var shot = (attempt: 1, message: "SHOT!", score: Int.random(in: 0...10))
var score: Double = 0

for i in 0...9 {
    var shot = (attempt: 1, message: "SHOT!", score: Int.random(in: 0...10))
    shot.attempt += i
    if shot.attempt == 7 {
        score -= 1
    } else if shot.score == 0 {
        print("Промах!")
        score -= 1
    } else if shot.score >= 1, shot.score <= 5, shot.attempt % 2 != 0 {
        score += Double(shot.score)
        score += Double(shot.score) * 0.2
    } else if shot.score >= 6, shot.score <= 10, shot.attempt % 2 == 0 {
        score += Double(shot.score)
        score += Double(shot.score) * 0.3
    } else {
        score += Double(shot.score)
    }
    print("\(shot.message)! Выстрел номер \(shot.attempt), результат - \(shot.score). Общий результат - \(score)")
}



// =================================
// MARK: - Task 4
// =================================
/*
 1. Создайте случайную строку случайной длины, состоящей из только из цифр

 2. Строка может начинаться с 0

 3. Посчитайте сумму цифр, которые содержатся в строке

 4. Через каждые 4 цифры вставьте символ "-"

 5. Если в строке будет найден любой другой символ или буква,
    то выбросьте ошибку с описанием символа, который не подходит */

// -----------------------------------------------
// MARK: - Task 4. Solution
// -----------------------------------------------
var strOfInt: String = ""
for _ in 0...Int.random(in: 16...100) {
    strOfInt += String(Int.random(in: 0...10))
}

var summOfStr: Int = 0
Array(strOfInt).forEach {
    if let i: Int = Int(String($0)) {
        summOfStr += i
    }
}
for i in 0...strOfInt.count {
    if i % 5 == 0 {
        strOfInt.insert("-", at: strOfInt.index(strOfInt.startIndex, offsetBy: i))
    }
}
enum strError: Error {
    case invalidSymbol
}

do {
    try Array(strOfInt).forEach {
        guard $0.isNumber || $0 == "-" else { throw strError.invalidSymbol }
    }
} catch {
    print("Неверный символ")
}
// -----------------------------------------------
// MARK: - Комплексные задачи
// -----------------------------------------------

// =================================
// MARK: - Task 1. Server Response
// =================================

/*
 Решим задачу, которая поможет нам реализовать логику обработки ответа от сервера.
 */

/// Ответ содержит 4 параметра:
///   - `statusCode` (обязательный)
///   - `message` (необязательный),
///   - `errorMessage` (необязательный) - все строковые значения
///   - `dictionary` со следующими ключами и значениям соответственно:
///     * `age` - возраст студента
///     * `name` - имя студента
///     * `surname` - фамилия студента
///
/// 1. Создайте класс `ResponseModel`, который содержит переменные, соответствующие ключам аргумента `dictionary` серверного ответа
///
/// 2. Создайте структуру `Response`, которая состоит из
///   - `statusCode` (обязательный, типа `Int`)
///   - `message` (обязательный),
///   - `errorMessage` (необязательный)
///   - `reponseModel` типа созданного вами класса в 1 пункте
///
/// 3. Создайте функцию `parseServerResponse`, которая в качестве аргументов принимает все 4 параметра из ответа сервера и возвращает `Response`
/// Функция должна возвращать объект `Response`, проинициализированный всеми property, учитывая следующие требования:
///   - Преобразовывать `statusCode` в Int. При неуспешном приведении реализовать ранний выход и вывести ошибку в консоль
///   - При отсутствии `message` использовать сообщение по умолчанию: `"OK"`
///   - Создавать объект `ResponseModel`, вычитывая ключи из`dictionary`. Если какого-либо ключа не пришло, то реализовать ранний выход и вывести ошибку в консоль
///
/// 4. Создайте ещё одну функцию `handleResponse`, которая обрабатывает `Response`:
///   - Выводит в консоль `message`, если `statusCode` от 200 до 300 включительно
///   - Для остальных кодов выводит `errorMessage`.
///   - В случае отсутствия `errorMessage`, выведите шаблонный текст ошибки (фантазируйте)
///
/// 5. Вызовите функцию `parseServerResponse`, сохранив ответ в переменную
///
/// 6. Вызовите функцию `handleResponse`
///
/// 7. Создайте ещё одну переменную типа `Response`, присвоив ей уже имеющуюся переменную `Response`
///
/// 8. Выведите в консоль имя студента из первой и второй переменной
///
/// 9. Поменяйте имя студента в первом ответе сервера
///
/// 10. Снова выведите в консоль имя студента из первой и второй переменной.
///
/// 11. Изменилось ли оно в двух переменных? Как?
/// Ваш подробный ответ запишите в переменную `answer`, которая будет содержать многострочный текст.
/// Содержание переменной `answer` выведите в консоль.


// -----------------------------------------------
// MARK: - Task 1. Solution
// -----------------------------------------------

/*
 Ваше решение можно оформить тут */

// MARK: - Енумы
enum ServerErrors: Error {
    case invalidStatusCode
    case invalidAge
    case invalidName
    case invalidSurname
}

// MARK: - Классы
class ResponseModel {
    var age: Int
    var name: String
    var surname: String
    
    init(age: Int, name: String, surname: String) {
        self.age = age
        self.name = name
        self.surname = surname
    }
}

// MARK: - Структуры
struct Response {
    var statusCode: Int
    var message: String
    var errorMessage: String?
    var reponseModel: ResponseModel
}


// MARK: - Методы
func parseServerResponse(statusCode: String,
                         message: String?,
                         errorMessage: String?,
                         dictionary: [String: String]) throws -> Response {
    guard let statusCode: Int = Int(statusCode) else { throw ServerErrors.invalidStatusCode }
    let message: String = message ?? "OK"
    
    guard let str: String = dictionary["age"] else { throw ServerErrors.invalidAge }
    guard let num: Int = Int(str) else { throw ServerErrors.invalidAge }
    guard let name: String = dictionary["name"] else { throw ServerErrors.invalidName }
    guard let surname: String = dictionary["surname"] else { throw ServerErrors.invalidSurname }
    let dictionary: ResponseModel = ResponseModel(age: num, name: name, surname: surname)
    
    let response: Response = Response(statusCode: statusCode, message: message, errorMessage: errorMessage, reponseModel: dictionary)
    return response
}

func handleResponse(result: Response) {
    if result.statusCode >= 200, result.statusCode <= 300 {
        print(result.message)
    } else {
        print(String(result.errorMessage ?? "Неизвестная ошибка"))
    }
}

// MARK: - Расширения
extension ServerErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidStatusCode:
            return NSLocalizedString("Ошибка получения статуса",
                                     comment: "")
        case .invalidAge:
            return NSLocalizedString("Ошибка получения возраста",
                                     comment: "")
        case .invalidName:
            return NSLocalizedString("Ошибка получения имени",
                                     comment: "")
        case .invalidSurname:
            return NSLocalizedString("Ошибка получения фамилии",
                                     comment: "")
        }
    }
}

// MARK: - Тест
var responce: Response = Response(statusCode: 0, message: "", errorMessage: nil, reponseModel: ResponseModel(age: 0, name: "", surname: ""))

do {
    responce = try parseServerResponse(statusCode: "250",
                                       message: "All OK",
                                       errorMessage: nil,
                                       dictionary: ["age": "23",
                                                    "name": "Alex",
                                                    "surname": "Petrov"])
} catch {
    print(error.localizedDescription)
}

handleResponse(result: responce)
var responce2 = responce
print(responce.reponseModel.name, responce2.reponseModel.name)
responce.reponseModel.name = "Oleg"
print(responce.reponseModel.name, responce2.reponseModel.name)

var answer: String = """
Имя изменилось в обеих переменных, так как имя хранится в классе ResponseModel, а это ссылочный тип. При копировании значений во вторую переменную мы создали ссылку, поэтому при изменении имени в первой переменной изменилоcь и имя во второй переменной
"""
print(answer)

// =================================
// MARK: - Task 2. Shop Basket
// =================================

/*
 Ниже представлено условие задачи, для которой я приложил решение.

 В этот раз, Вам будет нужно разобраться:
    - Как этот код работает?
    - Что в нем можно поменять?
    - Что можно упростить?
    - Что переписать?

 А затем, выполнить несколько заданий из списка ниже.
 Если что-то будет непонятно - спрашивайте.

 Умение разбираться в коде очень важно и полезно для разработчиков разного уровня. */


/// `Условие`
///
/// Реализуйте программу магазин, которая позволит пользователям пользоваться корзинками, складывать в них товар, а также рассчитваться за покупки.
/// 1. Реализуйте протокол `Shoppable`, который будет описывать:
///   -  `baskets` - массив корзинок и тележек
/// а также позволит реализовать функции `buy` и `fillBasket` (описание методов смотрите ниже по условию)
///
/// 2. Реализуйте классовый протокол `ShopItem`, который будет описывать:
///   - `id` (тип `UUID`) - уникальный идентификатор продукта
///   - `name` - String - название
///   - `weight`- Double - вес
///   - `pricePerKg` - Double - цена за килограмм
///   - `price` - Double - цена
///
/// 3. Создайте расширение для протокола `ShopItem`, в котором рассчитайте значение для computed property `price`
///   Цена должна рассчитываться по формуле: `цена за килограмм x ( вес / 1000 )`
///
/// 4. Создайте класс `Basket`, который состоит из:
///     - Типа корзины `basketType` типа`BasketType`
///     - массива товаров `goods` типа `[ShopItem]`
///
///     `BasketType` - перечисление, которое содержит:
///         * тип корзинки
///         - `handbasket` - ручная корзинка
///         - `trolleyBasket`- тележка
///
///         * максимальную вместительность каждой корзинки `maxGoodAmount` типа `Int` (computed property):
///                 -  4 единицы товара для корзинки
///                 - 10 единиц товара для тележки
///
///     В инициализаторе класса `Basket` реализуйте возможность случайной генерации типа корзинки для параметра `basketType`
///     Если создать не получилось - верните `handbasket`
///
/// 5. Создайте класс `Goods` и подчините его протоколу `ShopItem`
///
/// 6. Создайте классы `Fruit` and `Vegetable` и наследуйте их от класса `Goods`
///   - для фруктов добавьте поле `levelOfSweetness` типа `Int`
///   - для овощей - `levelOfRipeness` типа `Int`
///
/// 7. Реализуйте класс `Shop` и подчините его протоколу `Shoppable`:
///   - Массив корзинок и тележек `baskets` заполните самостоятельно в произвольном объеме.
///
///   Реализуйте методы:
///   - `getBasket` - который позволяет покупателю брать корзинку (-1 объект из массива `baskets`)
///     - `Basket.BasketType` - тип корзинки
///     Если не получилось взять корзинку - верните ошибку `noBasket`, которая сможет вывести сообщение в консоль,
///     что свободных корзин в магазине нет
///
///   - `calculateChange` - который вернет покупателю сдачу
///     - `customerCash`: Double - обязательный - сумма пользователя
///     - `totalAmount`: Double - обязательный - стоимость товаров из корзинки
///          а возвращает - `Change` (Double)
///     Метод должен уметь возвращать ошибку `notEnoughMoney`, если у пользователя не хватает денег на товары из корзины
///     А также сообщение в консоль
///
///   - а также реализуйте методы из протокола:
///     - `buy` -
///         - `basket`: - корзина покупателя
///         - `discountType` - тип товара, к которому будет применена скидка (Фрукты или Овощи)
///         - `discount` - размер скидки
///         - `paymentHandler` - `(Double) -> (Double)` - замыкание, которое передает сумму к оплате товара
///         - `successHandler` - `(Double) -> Void`  - замыкание об успешном выполнении операции
///         - `errorHandler` - замыкание, которое вызывается в случае нехватки денежных средств
///
///     - `fillBasket` - метод, который позволяет наполнить корзину покупателя покупками
///       - `basket`: - корзина покупателя
///       - `products` - товары из корзины
///       - `fillingBasketErrorHandler`: если не получилось заполнить корзину
///


// MARK: - Protocols
protocol Shoppable {
    typealias PaidAmount = Double
    typealias PaymentHandler = (_ totalAmount: Double) -> (PaidAmount)

    var baskets: [Basket] { get }

    func buy<T>(basket: Basket,
                discountType: T.Type,
                discount: Double,
                paymentHandler: PaymentHandler,
                successHandler: (Double) -> Void,
                errorHandler: (FinanceException) -> Void)

    func fillBasket(_ basket: inout Basket, with products: [ShopItem],
                    fillingBasketErrorHandler: ([ShopItem]) -> Void) -> Basket
}

protocol ShopItem: class {
    var id: UUID { get }
    var name: String { get }
    var weight: Double { get }
    var pricePerKg: Double { get set }

    var price: Double { get }
}

// MARK: - Extensions
extension ShopItem {
    var price: Double {
        pricePerKg * (weight / 1000)
    }
}

extension BasketException: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noBasket:
            return NSLocalizedString("No needed basket in shop", comment: "")
        }
    }
}

extension FinanceException: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notEnoughMoney:
            return NSLocalizedString("Need more money", comment: "")
        }
    }
}

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

// MARK: - Enums
enum Level {
    case low, medium, high
}

enum BasketException: Error {
    case noBasket
}

enum FinanceException: Error {
    case notEnoughMoney
}

// MARK: - Classes
class Basket {
    enum BasketType: CaseIterable {
        case handbasket, trolleyBasket

        var maxGoodAmount: Int {
            switch self {
            case .handbasket:
                return 10
            case .trolleyBasket:
                return 4
            }
        }
    }

    var basketType: BasketType
    var goods: [ShopItem] = []

    init() {
        self.basketType = BasketType.allCases.randomElement() ?? .handbasket
    }
}

class Goods: ShopItem {
    var id: UUID = UUID()
    var name: String
    var weight: Double
    var pricePerKg: Double

    init(name: String, weight: Double, pricePerKg: Double) {
        self.name = name
        self.weight = weight
        self.pricePerKg = pricePerKg
    }
}

class Fruit: Goods {
    let levelOfSweetness: Level

    init(levelOfSweetness: Level, name: String, weight: Double, pricePerKg: Double) {
        self.levelOfSweetness = levelOfSweetness
        super.init(name: name, weight: weight, pricePerKg: pricePerKg)
    }
}

class Vegetable: Goods {
    let levelOfRipeness: Level

    init(levelOfRipeness: Level, name: String, weight: Double, pricePerKg: Double) {
        self.levelOfRipeness = levelOfRipeness
        super.init(name: name, weight: weight, pricePerKg: pricePerKg)
    }
}

class Shop: Shoppable {
    typealias Change = Double

    var baskets: [Basket]

    init(baskets: [Basket]) {
        self.baskets = baskets
    }

    // MARK: - Метод расчета сдачи
    private func calculateChange(customerCash: Double, totalAmount: Double) throws -> Change {
        print("You gave me: \(customerCash)")
        guard customerCash >= totalAmount else { throw FinanceException.notEnoughMoney }        // Проверяем на соответствие количества товаров

        return customerCash - totalAmount                                                       // Рассчитываем сдачу
    }
    
    // MARK: - Метод взять корзину
    func getBasket(type: Basket.BasketType) throws -> Basket {
        let basket = baskets
            .filter { $0.basketType == type }                                       // Проверка на наличие корзины нужного типа
            .first
        if let basket = basket {                                                    // Берем корзину и удаляем из общего массива
            self.baskets.removeLast()
            return basket
        } else {
            throw BasketException.noBasket
        }
    }
    // MARK: - Метод наполнения корзины продуктами
    func fillBasket(_ basket: inout Basket,
                    with products: [ShopItem],
                    fillingBasketErrorHandler: ([ShopItem]) -> Void) -> Basket {
        for product in products {
            if basket.goods.count < basket.basketType.maxGoodAmount {                       // Проверка на количество товаров в корзине
                basket.goods.append(product)
            } else {
                fillingBasketErrorHandler(products.filter { product in                      // Лишние товары кладем в соответствующий массив
                    !basket.goods.contains { $0.id == product.id }
                })
            }
        }
        return basket
    }

    // MARK: - Метод рассчета за товары, лежащие в корзине
    func buy<T>(basket: Basket,
                discountType: T.Type,
                discount: Double,
                paymentHandler: (Double) -> (Shop.PaidAmount),
                successHandler: (Double) -> Void,
                errorHandler: (FinanceException) -> Void) {
        basket.goods.map { if $0 is T { $0.pricePerKg *= discount } }

        var totalAmount: Double = 0
        basket.goods.forEach { totalAmount += $0.price }                                        // Подсчет стоимости товаров в корзине
        baskets.append(basket)                                                                  // Возвращаем корзину на место

        do {
            try successHandler(self.calculateChange(customerCash: paymentHandler(totalAmount),  // Проверяем деньги и при нехватке выводим
                                                    totalAmount: totalAmount))                  // ошибку
        } catch let error as FinanceException {
            errorHandler(error)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

// MARK: - Body
let apple = Fruit(levelOfSweetness: .medium, name: "Apple", weight: 1000, pricePerKg: 15)
let banana = Fruit(levelOfSweetness: .low, name: "Banana", weight: 800, pricePerKg: 13)
let orange = Fruit(levelOfSweetness: .medium, name: "Orange", weight: 1500, pricePerKg: 20)
let ananas = Fruit(levelOfSweetness: .high, name: "Ananas", weight: 900, pricePerKg: 25)

let tomato = Vegetable(levelOfRipeness: .high, name: "Tomato", weight: 500, pricePerKg: 45)
let potatoes = Vegetable(levelOfRipeness: .high, name: "Potatoes", weight: 760, pricePerKg: 39)
let cucumber = Vegetable(levelOfRipeness: .high, name: "Cucumber", weight: 400, pricePerKg: 12.3)
let pepper = Vegetable(levelOfRipeness: .high, name: "Pepper", weight: 350, pricePerKg: 45.9)

let milk = Goods(name: "Milk", weight: 1000, pricePerKg: 50)

let baskets = [Basket(), Basket(), Basket()]

let shop = Shop(baskets: baskets)
shop.baskets.forEach {
    print($0.basketType)
}

do {
    var basket = try shop.getBasket(type: .handbasket)
    shop.fillBasket(
        &basket,
        with: [apple, tomato, banana, orange, ananas, potatoes, cucumber, pepper, apple, milk]) {
        print("Following products weren't added: \($0.map { $0.name })")
    }
    shop.buy(
        basket: basket,
        discountType: Fruit.self,
        discount: 0.5,
        paymentHandler: { (totalAmount) -> (Shop.PaidAmount) in
            print("Your total amount is: \(totalAmount.rounded(toPlaces: 2))")
            return totalAmount.rounded(toPlaces: 2) + 15 },
        successHandler: { (change) in
            print("Your change is \(change.rounded(toPlaces: 2))")},
        errorHandler: { error in
            print("Give me more money!")})
} catch let error as BasketException {
    print(error.localizedDescription)
}



/// `Дополнительное задание`
/// `1. Реализовать функционал, который позволит вернуть корзинки в магазин`
///     - как при успешном, так  при и неуспешном расчете покупателя

/// `2. Все суммы, которые отображаются в консоли должны содержать только два знака после точки / запятой`
///     (Частая задача на продакшне при разработке финансовых приложений)
///
/// `3. Задокументировать код `
///     - Напишите по всем правилам, что делает каждая из функций в программе
///
/// `4. Реализуйте заполнение корзины пользователя различными товарами с разными ценами в различном объеме`
///     - Можете добавить новые категории товаров или случайным оьбразом

