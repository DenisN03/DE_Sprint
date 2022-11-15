//  Кажется, вы взяли в вашу команду еще одного сотрудника и предложили ему оклад 130 тысяч.
//  Вычислите самостоятельно номер сотрудника в списке так, чтобы сортировка не нарушилась и добавьте его на это место.

import scala.io.StdIn.readLine

object task_f {

  def main(args: Array[String]): Unit = {

    var salaries: Array[Int] = Array(100, 150, 200, 80, 120, 75, 350, 90)

    salaries = salaries.sorted

    // Добавление еще одного сотрудника
    println("Do you want to add an employee? (Y/N)")
    val answer: String = readLine()

    if (answer.toLowerCase == 'y'.toString) {
      println("Enter salary:")
      val new_salary: Int = scala.io.StdIn.readInt()

      // Вычисление индекса для вставки
      val indx: Int = salaries.indexWhere(element => element > new_salary)
      // Добавление нового значения в массив
      salaries = salaries.patch(indx, Array(new_salary), 0)
    }

    // Вывод информации об уровне зарплат
    println(s"Sorted salaries:");
    for (salary <- salaries) {
      println(s"Salary: ${salary}.");
    }

  }

}
