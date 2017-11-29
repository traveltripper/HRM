module PollsHelper

	def caliculate_percentage(questionid, answerid)
		
		pollscount = Poll.where(pollquestion_id: questionid).count
		
		answercount = Poll.where(pollanswer_id: answerid).count
        
        if pollscount == 0
        	percentage = 0
        else
        	percentage = (answercount * 100 / pollscount)  
        end
	end

	def check_poll_status(questionid)
		Poll.where(employee_id: current_employee.id, pollquestion_id: questionid ).count 
	end
end
