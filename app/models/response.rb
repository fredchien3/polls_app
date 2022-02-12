class Response < ApplicationRecord
  validates :answer_choice_id, presence: true
  validates :respondent_id, presence: true

  validate :respondent_already_answered?
  validate :author_cant_respond_to_own_poll

  belongs_to :respondent,
    class_name: 'User',
    foreign_key: :respondent_id,
    primary_key: :id

  belongs_to :answer_choice,
    class_name: 'AnswerChoice',
    foreign_key: :answer_choice_id,
    primary_key: :id

  has_one :question,
    through: :answer_choice

  def sibling_responses
    if self.id
      self.question.responses.where.not('responses.id = ?', self.id)
    else
      self.question.responses
    end
  end

  def respondent_already_answered?
    if self.sibling_responses.exists?(responses: {respondent_id: self.respondent_id})
      errors[:respondent] << 'can\'t have already answered this question'
    end
  end

  def author_cant_respond_to_own_poll
    if self.question.poll.author_id == self.respondent_id
      errors[:respondent] << 'can\'t respond to their own poll'
    end
  end

end