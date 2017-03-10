import Vapor
import HTTP

let drop = Droplet()

drop.get("/fizz") { request in
    if let num = request.query?["q"]?.int{
        var retString = ""
        
        for i in 1...num{
            if i % 3 == 0 && i % 5 == 0 {
                retString.append("FizzBuzz")
            }else if i % 3 == 0 {
                retString.append("Fizz")
            }else if i % 5 == 0 {
                retString.append("Buzz")
            }else{
                retString.append(String(i))
            }
            if i != num{
                retString.append(", ")
            }
        }
        
        let retJSON = try JSON(node: [
            "fizzbuzz": retString
        ])
        
        return try Response(status: .ok, json: retJSON)
    }else{
        let retJSON = try JSON(node: [
                "error": "Use the \'q\' parameter"
            ])
        
        return try Response(status: .badRequest, json: retJSON)
    }
}

drop.resource("posts", PostController())

drop.run()
