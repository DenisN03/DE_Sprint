// Напишите программу, которая рассчитывает для каждого сотрудника отклонение (в процентах) от среднего
// значения оклада на уровень всего отдела. В итоговом значении должно учитываться в большую или меньшую
// сторону отклоняется размер оклада. На вход вышей программе подаются все значения, аналогичные
// предыдущей программе, а также список со значениями окладов сотрудников отдела 100, 150, 200, 80, 120, 75.

object task_c {

  def main(args: Array[String]): Unit = {

    val salaries: Array[Int] = Array(100, 150, 200, 80, 120, 75)

    //Sum using for loop
    var total = 0.0;
    for (i <- 0 to (salaries.length - 1)) {
      total += salaries(i);
    }
    val salary_mean: Double = (total/salaries.length).round
    val salary_percent: Double = (salary_mean/100)

    for (i <- 0 to (salaries.length - 1)) {
      println(s"\nEmployee number: ${i} has salary ${salaries(i)}, which is ${((salaries(i) - salary_mean)/salary_percent).round}% than mean ($salary_mean).");
    }


  }

}
