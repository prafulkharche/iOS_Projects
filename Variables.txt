

🔹 What is a Variable?
A variable stores data that can change during program execution.

🔹 Declaring a Variable
Use `var`:
```
var name = "John"
var age = 25
```
Swift automatically infers the type.

🔹 Explicit Type Declaration
```
var city: String = "Mumbai"
var score: Int = 100
```

🔹 Constants (`let`) vs Variables (`var`)
- `let` → constant (unchangeable)
- `var` → variable (changeable)
```
let pi = 3.14
var radius = 5
radius = 10 // ✅
pi = 3.1415 // ❌ Error
```

🔹 Type Safety
Once a type is assigned, it can't change:
```
var age = 25
age = "twenty-five" // ❌ Error
```

✅ Best Practice
- Use `let` by default
- Use `var` only when you need to change the value
