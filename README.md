# devops-netology


    3. Написание кода

1. 
```golang
package main
import "fmt"

func main() {
    var meter float64 = -1

    if meter < 0 {
	fmt.Print("Enter meters: ")
	fmt.Scanf("%f", &meter)
    }

    foot := meter * 0.3048
    fmt.Println(fmt.Sprint(meter) + " meters are " + fmt.Sprintf("%.5f", foot) + " feet")
}
```
2.
```golang
package main
import "fmt"

func main() {
    x := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17,}
    var min int = x[0]

    for i := range x  {
	if x[i] < min {
	    min = x[i]
	}
    }
    fmt.Println(min)
}
```
3.
```golang
package main
import "fmt"

func main() {
    for i := 1; i <= 100; i++ {
	if i % 3 == 0 {
	    fmt.Println(i)
	}
    }
}
```





