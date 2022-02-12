class Question < ApplicationRecord
  validates :text, presence: true
  validates :poll_id, presence: true

  belongs_to :poll,
    class_name: 'Poll',
    foreign_key: :poll_id,
    primary_key: :id

  has_many :answer_choices,
    class_name: 'AnswerChoice',
    foreign_key: :question_id,
    primary_key: :id

  has_many :responses,
    through: :answer_choices

  def results
    # results = Hash.new(0)
    # self.answer_choices.includes(:responses).each do |ac|
    #   results[ac.text] += 1
    # end
    # results

    # results = Hash.new(0)
    # acs = AnswerChoice.find_by_sql([<<-SQL, self.id]) 
    #   SELECT answer_choices.text, COUNT(responses.id) AS num_responses
    #   FROM answer_choices
    #   LEFT OUTER JOIN responses ON responses.answer_choice_id = answer_choices.id
    #   WHERE answer_choices.question_id = ?
    #   GROUP BY answer_choices.id
    # SQL
    # acs.each do |ac|
    #   results[ac.text] = ac.num_responses
    # end
    # results

    results = Hash.new(0)
    acs = self.answer_choices
      .select('answer_choices.text, COUNT(responses.id) AS num_responses')
      .left_outer_joins(:responses)
      # .where('answer_choices.question_id = ?', self.id)
      .group('answer_choices.id')
    acs.each do |ac|
      results[ac.text] = ac.num_responses
    end
    results
  end

end