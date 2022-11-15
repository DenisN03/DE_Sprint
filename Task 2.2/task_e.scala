// Также в вашу команду пришли два специалиста с окладами 350 и 90 тысяч рублей. Попробуйте отсортировать
// список сотрудников по уровню оклада от меньшего к большему.

import scala.io.StdIn.readLine

object task_e {

  def main(args: Array[String]): Unit = {

    var salaries: Array[Int] = Array(100, 150, 200, 80, 120, 75, 350, 90)

    // Дополнительно можно добавить еще одного сотрудника
    println("Do you want to add a salary? (Y/N)")
    val answer: String = readLine()

    if (answer.toLowerCase == 'y'.toString) {
      println("Enter salary:")
      val new_salary: Int = scala.io.StdIn.readInt()

      salaries = salaries :+ new_salary

    }

    salaries = salaries.sorted

    // Вывод информации об уровне зарплат
    println(s"Sorted salaries:");
    for (salary <- salaries) {
      println(s"Salary: ${salary}.");
    }

  }

}
