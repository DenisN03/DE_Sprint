object task_a {

  def remove_symbol(x: String, y: String): Unit = {
    val toRemove = y.toSet
    println(x.filterNot(toRemove))
  }

  def main(args: Array[String]): Unit = {
    val s = "Hello, Scala!"
    println(s)
    //  выводим фразу «Hello, Scala!» справа налево
    println(s.reverse)
    // переводим всю фразу в нижний регистр
    println(s.toLowerCase)
    // удаляем символ "!"
    remove_symbol(s, "!")
    // добавляем в конец фразы «and goodbye python!»
    val s2 = " and goodbye python!"
    println(s + s2)
  }
}