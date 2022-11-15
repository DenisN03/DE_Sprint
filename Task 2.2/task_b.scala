// Напишите программу, которая вычисляет ежемесячный оклад сотрудника после вычета налогов.
// На вход вашей программе подается значение годового дохода до вычета налогов, размер премии –
// в процентах от годового дохода и компенсация питания.

object task_b {

  def main(args: Array[String]): Unit = {

    println("Enter gross value:")
    val g: Float = scala.io.StdIn.readFloat()

    println("Enter premium percent:")
    val p: Float = scala.io.StdIn.readFloat()

    println("Enter compensation value:")
    val c: Float = scala.io.StdIn.readFloat()

    var tax: Float = 13
    var base: Float = g - g * ( tax / 100 )
    var base_p: Float = base - base * ( p / 100 )
    var base_c: Float = base_p - c
    var salary: Float = base_c / 12

    println("The monthly salary is " + salary)

  }

}
