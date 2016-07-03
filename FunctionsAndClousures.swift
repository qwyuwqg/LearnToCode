//함수는 func를 이용해서 정의. ->를 사용하여 함수의 Return Type을 지정.

func hello(name: String, time: Int) -> String {
    var string = ""
    for _ in 0..<time {
        string += "Hello, \(name)\n"
    }
    
    return string
}

//Swifts는 함수를 호출시 Parameter의 이름을 같이 써야 함.

print(hello(name: "ㅎㅅㅎ", time: 3))

//함수 영역 내의 Parameter 이름과 호출 시의 이름을 다르게 한다면 아래와 같이 Argument Label을 Parameter 앞에 붙여 주면 된다. 이떄, Argument Label을 _로 설정 시, 함수를 호출할 떄, Parameter의 이름을 생략할 수 있다.

func helloAgain(_ name: String, numberOfTimes time: Int) -> String {
    var string = ""
    for _ in 0..<time {
        string += "Hello, \(name)\n"
    }
    
    return string
}

print(helloAgain("ㅎㅅㅎ", numberOfTimes: 3))

//Parameter의 기본값을 지정하는 것도 가능. 이 경우에는 함수 호출시 Parameter 이름을 생략.

func helloAgainAgain(name: String, time: Int = 3) -> String {
    var string = ""
    for _ in 0..<time {
        string += "Hello, \(name)\n"
    }
    
    return string
}

print(helloAgainAgain(name: "ㅎㅅㅎ"))

//...을 사용해서 개수 미정의 Parameter를 받는 것도 가능.

func sum(_ numbers: Int...) -> Int {
    var sum = 0
    for number in numbers{
        sum += number
    }
    
    return sum
}

print(sum(1,2,3))
print(sum(3,4,6,2,7,3))

/*
 함수 안에 함수를 작성하는 과정과 이를 통해 함수 안에서 정의한 함수를 반환하는 게 가능하고, 이를 Closure를 통해 간결하게 프로그래밍할 수 있다.
 */

//함수 안에서 함수를 선언.

func pleaseStopHello(_ name: String, time: Int) {
    func message(_ name: String) -> String {
        return "Hello, \(name)"
    }
    
    for _ in 0..<time {
        print(message(name))
    }
}

pleaseStopHello("ㅎㅅㅎ", time: 3)

//함수가 함수를 반환?? 😮

func helloGenerator(_ message: String) -> (String, String) -> String {
    func hello(_ firstName: String, _ lastName: String) -> String {
        return message + lastName + firstName
    }
    return hello
}

let hello = helloGenerator("Hi, ")
print(hello("ㅅㅎ","ㅎ"))

//이걸 Closure를 사용하여 나타내는 것이 가능.
// * 아래 특징을 보면, 함수는 이름이 있는 Closure라고도 볼 수 있다.

func helloGeneratorWithClosure(_ message: String) -> (String, String) -> String {
    return { (firstName: String, lastName: String) -> String in
        return message + lastName + firstName
    }
}

let helloClosure = helloGeneratorWithClosure("Hi, ")
print(helloClosure("ㅅㅎ", "ㅎ"))

//Closure의 장점은 유연성과 간결성에 있다. 이를 통해 코드의 길이를 효과적으로 줄일 수 있다.
//LLVM 기반의 Swift 컴파일러는 포괄하는 함수를 통해 클로저가 Parameter와 Return이 어느 타입을 사용하는지 추론하는 기능을 제공한다. 이떄, Closure를 호출할 때에는 Parameter의 이름을 쓰지 않아도 좋다.

func helloGeneratorConcile(_ message: String) -> (String, String) -> String {
    return { firstName, lastName in
        return message + lastName + firstName
    }
}

let helloConcile = helloGeneratorConcile("Hi, ")
print(helloConcile("ㅅㅎ", "ㅎ"))

//그리고 심지어는... String인 Parameter를 $0, $1, $2, ... 로 생략해버리는 것도 가능하다.

func helloGenSuperConcile(_ message: String) -> (String, String) -> String {
    return {
        return message + $1 + $0
    }
}

let helloSuperConcile = helloGenSuperConcile("Hi, ")
print(helloSuperConcile("ㅅㅎ", "ㅎ"))

//그리고 그리고 심지어는... Closure의 내용물이 한 줄밖에 없으면... 😱 return을 쓰지 않아도 되므로 최종적으로 코드는 다음과 같이 매우 간단한 형태로 나타난다.

func helloGenSuperSuperConcile(_ message: String) -> (String, String) -> String {
    return { message + $1 + $0 }
}

let helloSuperSuperConcile = helloGenSuperSuperConcile("Hi, ")
print(helloSuperConcile("ㅅㅎ","ㅎ"))
