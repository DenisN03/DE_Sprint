// Однако наступил кризис и ваши сотрудники требуют повысить зарплату. Вам необходимо проиндексировать
// зарплату каждого сотрудника на уровень инфляции – 7%

object task_h {

  def main(args: Array[String]): Unit = {

    var salaries: Array[Int] = Array(100, 150, 200, 80, 120, 75, 350, 90, 130)

    val indexing: Int = 7

    // Индексация
    for (i <- 0 to (salaries.length - 1)) {
      println(s"Employee number: ${i} has old salary ${salaries(i)}.");
      salaries(i) = salaries(i) + ( salaries(i) * indexing / 100 ).toInt
      println(s"Employee number: ${i} has new salary ${salaries(i)}.");
    }

  }

}
