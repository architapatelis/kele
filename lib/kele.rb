# We place the code for a gem within the lib directory.
# gets loaded when we call require './lib/kele'

require "httparty"
require 'json'
require './lib/roadmap'

class Kele
  include HTTParty
  include Roadmap

  base_uri "https://www.bloc.io/api/v1"


  def initialize(email, password)
    response = self.class.post("/sessions", body: {email: email, password: password})

    @auth_token = response["auth_token"]

    raise "Wrong Email and/or Password" if response.code != 200
  end

  def get_me
    response = self.class.get("/users/me", headers: { "authorization" => @auth_token })
    @user_data = JSON.parse(response.body)
  end

  def get_mentor_availability
    response = self.class.get("/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @auth_token})

    @mentor_availability = JSON.parse(response.body)

  end

  def get_messages(page = nil)
    if page == nil
      total_num_of_pages = (JSON.parse(self.class.get("/message_threads", headers: { "authorization" => @auth_token }).body)["count"])/10+1

      @messages = (1..total_num_of_pages).map{ |n| JSON.parse(self.class.get("/message_threads", body: { page: n }, headers: { "authorization" => @auth_token }).body) }
    else
      @messages = JSON.parse(self.class.get("/message_threads", body: { page: page }, headers: { "authorization" => @auth_token }).body)
    end
  end

  def create_message(sender_email, recipient_id, subject, message_body)
    response = self.class.post("/messages", headers: { "authorization" => @auth_token }, body: {'sender': sender_email,  'recipient_id': recipient_id, 'subject': subject, 'stripped-text': message_body})

    puts "Message sent!" if response.success?
  end

  def get_checkpoint(checkpoint_id)
    response = self.class.get("https://www.bloc.io/api/v1/checkpoints/#{checkpoint_id}", headers: { "authorization" => @auth_token })
    @checkpoint = JSON.parse(response.body)
  end

  def create_submission(checkpoint_id, assignment_branch = nil, assignment_commit_link = nil, comment)
    response = self.class.post('/checkpoint_submissions', headers: { "authorization" => @auth_token }, body: { "enrollment_id": 24636, "checkpoint_id": checkpoint_id, "assignment_branch": assignment_branch, "assignment_commit_link": assignment_commit_link, "comment": comment })

    puts "Checkpoint Submitted!" if response.success?
  end
end
