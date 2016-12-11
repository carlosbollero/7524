/**
 * Ejercicio 3
 * Implementación de Diccionario en Kotlin
 * modalidad Open-Declarative-Unbundled
 */

class Diccionario(){
    fun new(): BinaryTree?{
        return null
    }
    fun put(key: Char, tree: BinaryTree?): BinaryTree?{
        when{
            tree == null -> return BinaryTree(key, 1)
            key == tree.key -> return BinaryTree(key, tree.value+1, tree.leftTree, tree.rightTree)
            key < tree.key -> return BinaryTree(tree.key,tree.value, put(key,tree.leftTree),tree.rightTree)
            key > tree.key -> return BinaryTree(tree.key,tree.value, tree.leftTree, put(key,tree.rightTree))
        }
        return tree
    }

    private fun putByValue(key: Char,value: Int, tree: BinaryTree?): BinaryTree?{
        when{
            tree == null -> return BinaryTree(key,value,null,null)
            value < tree.value ->
                return BinaryTree(tree.key,tree.value,putByValue(key,value,tree.leftTree),tree.rightTree)
            value > tree.value ->
                return BinaryTree(tree.key,tree.value,tree.leftTree,putByValue(key,value,tree.rightTree))
            value == tree.value ->
                    if (key < tree.key){
                        return BinaryTree(tree.key,tree.value,putByValue(key,value,tree.leftTree),tree.rightTree)
                    }else{
                        return BinaryTree(tree.key,tree.value,tree.leftTree,putByValue(key,value,tree.rightTree))
                    }
        }
        return tree
    }

    private fun sortByFreq(orig: BinaryTree?, new: BinaryTree?): BinaryTree?{
        if (orig == null) return new
        else{
            return sortByFreq(orig.rightTree,sortByFreq(orig.leftTree,putByValue(orig.key,orig.value,new)))
        }
    }

    fun insertList(list: List<Char>, tree: BinaryTree?): BinaryTree?{
        if (list.isNotEmpty()){
            val head = list.first()
            return insertList(list.drop(1), put(head, tree))
        }
        else{
            return tree
        }
    }

    fun get(key: Char?, tree: BinaryTree?): Int{
        if (key != null && tree != null){
            when{
                key == tree.key -> return tree.value
                key < tree.key -> get(key,tree.leftTree)
                key > tree.key -> get(key,tree.rightTree)
            }
        }
        return 0
    }

    fun domain(tree: BinaryTree?):BinaryTree?{
        return sortByFreq(tree,this.new())
    }

    fun print(tree: BinaryTree?){
        if (tree != null){
            this.print(tree.leftTree)
            print("${tree.key} (${tree.value}), ")
            this.print(tree.rightTree)
        }

    }
}