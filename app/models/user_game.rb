class UserGame < ApplicationRecord
  belongs_to :user
  belongs_to :game
  has_one :pacman

  def words_list_validation
    validated = answer.split
    answer = { answers: validated }
    answer.to_json
  end

  def words_list_score
    json_answers = JSON.parse answer
    answers = json_answers["answers"]
    solution = game.solution.to_f
    (100 * answers.length / solution).round
  end

  def nasa_validation
    validated = answer.split("/")
    answer = { answers: validated }
    answer.to_json
  end

  def nasa_score
    json_answers = JSON.parse answer
    answers = json_answers["answers"]
    solution = JSON.parse game.solution
    list = solution["solutions_list"]
    count = 0
    answers[0...-1].each_with_index do |answer, answer_index|
      answers[answer_index+1..-1].each do |comparative|
        list.index(answer) < list.index(comparative) ? count += 1 : count += 0
      end
    end
    (100 * count / (list.length * (list.length - 1) / 2).to_f).round
  end

  def lecture_yeux_validation
    validated = answer.split(";")
    answer = { answers: validated }
    answer.to_json
  end

  def lecture_yeux_good_answers
    json_answers = JSON.parse answer
    answers = json_answers["answers"]
    solution = JSON.parse game.solution
    solution = solution["solutions_list"]
    count = 0
    answers[0...-1].each_with_index do |answer, index|
      answer == solution[index] ? count += 1 : count += 0
    end
    count
  end

  def lecture_yeux_score
    solution = JSON.parse game.solution
    solution = solution["solutions_list"]
    (100 * lecture_yeux_good_answers.to_f / solution.length).round
  end
end
