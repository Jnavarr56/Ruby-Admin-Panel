json.extract! assignment, :id, :assignment_title, :assignment_descriotion, :section_id, :due_date, :created_at, :updated_at
json.url assignment_url(assignment, format: :json)
