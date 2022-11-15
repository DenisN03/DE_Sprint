// Попробуйте рассчитать новую зарплату сотрудника, добавив(или отняв, если сотрудник плохо себя вел)
// необходимую сумму с учетом результатов прошлого задания. Добавьте его зарплату в список и вычислите
// значение самой высокой зарплаты и самой низкой.

import scala.io.StdIn.readLine
import scala.util.control.Breaks.break

object task_d {

  def main(args: Array[String]): Unit = {

    val salaries: Array[Int] = Array(100, 150, 200, 80, 120, 75)

    val salary_total: Float = salaries.sum
    val salary_mean: Double = (salary_total/salaries.length).round

    while(true) {

      // Вывод информации об уровне зарплат
      for (i <- 0 to (salaries.length - 1)) {
        println(s"Employee number: ${i} has salary ${salaries(i)}, which is ${(salaries(i) - salary_mean)} than mean ($salary_mean).");
      }

      println("Do you want to change some salary? (Y/N)")
      val answer: String = readLine()

      if (answer.toLowerCase == 'n'.toString) {
        println("Exit.")
        break
      }

      // Изменение зарплаты
      println("Choose employee:")
      val employee: Int = scala.io.StdIn.readInt()

      if (employee > salaries.length) {
        println(s"Employee num must be at 0 - ${salaries.length - 1}. Exit.")
        break
      }

      println("Change salary:")
      val ch_salary: Float = scala.io.StdIn.readFloat()

      salaries(employee) = salaries(employee) + ch_salary.toInt

      // Вычисление максимальной и минимальной зарплаты
      println(s"\nMax salary ${salaries.max}")
      println(s"Min salary ${salaries.min}")

    }

  }

}
