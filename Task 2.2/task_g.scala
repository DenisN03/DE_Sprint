// Попробуйте вывести номера сотрудников из полученного списка, которые попадают под категорию middle.
// На входе программе подается «вилка» зарплаты специалистов уровня middle.

import scala.io.StdIn.{readInt, readLine}

object task_g {

  def main(args: Array[String]): Unit = {

    var salaries: Array[Int] = Array(100, 150, 200, 80, 120, 75, 350, 90, 130)

    // Сортировка уровня зарплат
    salaries = salaries.sorted

    // Пользовательский ввод для вилки зарплат уровня middle
    println("Enter middle min salary:")
    val middle_min: Int = readInt()
    println("Enter middle max salary:")
    val middle_max: Int = readInt()

    // Вывод номеров специалистов уровня middle
    for (i <- 0 to (salaries.length - 1)) {
      if ((salaries(i) >= middle_min) && (salaries(i) <= middle_max))
        println(s"Employee number: ${i} has salary ${salaries(i)}.");
    }

  }

}
