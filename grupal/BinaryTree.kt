/**
 * Ejercicio 3
 * Implementación de Diccionario en Kotlin
 * modalidad Open-Declarative-Unbundled
 */

data class BinaryTree(val key: Char,
                      val value: Int,
                      val leftTree: BinaryTree? = null,
                      val rightTree: BinaryTree? = null)
