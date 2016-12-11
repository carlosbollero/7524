/**
 * Ejercicio 3
 * Implementación de TDA Diccionario en Kotlin
 * modalidad Open-Declarative-Unbundled
 */

fun main(args: Array<String>) {

    val dic = Diccionario()
    val list = listOf('a','c','a','b','d','k','a','c','k','f','t','t','c','c','z','f','h','e','i','c','c','a')
    var tree = dic.insertList(list, dic.new())
    dic.print(tree)
    println()
    dic.print(dic.domain(tree))
}
/**
 * /usr/lib/jvm/java-8-openjdk-amd64/bin/java ...
 * a (4), b (1), c (6), d (1), e (1), f (2), h (1), i (1), k (2), t (2), z (1),
 * b (1), d (1), e (1), h (1), i (1), z (1), f (2), k (2), t (2), a (4), c (6),
 * Process finished with exit code 0
 */




