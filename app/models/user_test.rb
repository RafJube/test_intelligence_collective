class UserTest < ApplicationRecord
  belongs_to :user
  belongs_to :test

  def words_list_validation
    validated = answer.split
    answer = { answers: validated }
    answer.to_json
  end

  def words_list_score
    json_answers = JSON.parse answer
    answers = json_answers["answers"]
    solution = test.solution.to_f
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
    solution = JSON.parse test.solution
    list = solution["solutions_list"]
    count = 0
    answers[0...-1].each_with_index do |answer, answer_index|
      answers[answer_index+1..-1].each do |comparative|
        list.index(answer) < list.index(comparative) ? count += 1 : count += 0
      end
    end
    (100 * count / (list.length * (list.length - 1) / 2).to_f).round
  end
end
