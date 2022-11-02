class ListeDeMotsController < ApplicationController
  require 'oxford_dictionary'

  def word_validation
    word = remove_accents(params[:word].downcase)
    words = params[:words]
    response = { word: word }
    if word_character_validation?(word) && respect_rules?(word) && !words.include?(word)
      status = "under validation"
      # status = "validated"
    else
      status = "refused"
    end
    if status == "under validation" && dictionnary_valid?(word, "fr")
      status = "validated"
      words += "#{word} "
    else
      status = "refused"
      # words += "#{word} "
    end
    response[:word] = word
    response[:validation] = status
    response[:words] = words
    render json: response.to_json
  end

  def word_character_validation?(word)
    word.scan(/(\W|\d)/).empty?
  end

  def respect_rules?(word)
    word[0] == "a" && word[-1] == "n"
  end

  def dictionnary_valid?(word, language)
    # client = OxfordDictionary::Client.new(app_id: ENV['OXFORD_ID'], app_key: ENV['OXFORD_API_KEY'])
    client = OxfordDictionary.new(app_id: ENV['OXFORD_ID'], app_key: ENV['OXFORD_API_KEY'])
    answer = client.lemma(word: word, language: language, params: {})
    answer.results.present?
  end

  def remove_accents(word)
    word.tr(
      "ÀÁÂÃÄÅàáâãäåĀāĂăĄąÇçĆćĈĉĊċČčÐðĎďĐđÈÉÊËèéêëĒēĔĕĖėĘęĚěĜĝĞğĠġĢģĤĥĦħÌÍÎÏìíîïĨĩĪīĬĭĮįİıĴĵĶķĸĹĺĻļĽľĿŀŁłÑñŃńŅņŇňŉŊŋÒÓÔÕÖØòóôõöøŌōŎŏŐőŔŕŖŗŘřŚśŜŝŞşŠšſŢţŤťŦŧÙÚÛÜùúûüŨũŪūŬŭŮůŰűŲųŴŵÝýÿŶŷŸŹźŻżŽž",
      "AAAAAAaaaaaaAaAaAaCcCcCcCcCcDdDdDdEEEEeeeeEeEeEeEeEeGgGgGgGgHhHhIIIIiiiiIiIiIiIiIiJjKkkLlLlLlLlLlNnNnNnNnnNnOOOOOOooooooOoOoOoRrRrRrSsSsSsSssTtTtTtUUUUuuuuUuUuUuUuUuUuWwYyyYyYZzZzZz")
  end
end
