require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'date'


def restart
	load 'event_manager.rb'
end

def clean_zipcode(zipcode)
	zipcode.to_s.rjust(5, "0")[0..4]
end

def clean_phone(phone)
	phone.tr!('-''()'' ''.', '') unless phone == nil
	if (phone.length > 10 && phone[0] != "1") || phone.length < 10
		puts "No valid phone number provided."
	elsif phone.length > 10 && phone[0] == "1"
		phone[1..9]
	else
		return phone
	end
end

def reg_date_time(reg)
	DateTime.strptime(reg, "%m/%d/%y %H:%M")
end

def feedback_report_hours(array)
	hour_array = array.map {|row| row.strftime('%l %p')}
	hour_array.tally.sort_by{|k, v| v}.reverse!
end

def feedback_report_day(array)
	day_array = array.map {|row| row.strftime('%A')}
	day_array.tally.sort_by{|k, v| v}.reverse!
end

def legislators_by_zipcode(zip)
	civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
	civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

	begin	
		legislators = civic_info.representative_info_by_address(
			address: zip,
			levels: 'country',
			roles: ['legislatorUpperBody', 'legislatorLowerBody']).officials
	rescue
		"You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials"
	end
end

def save_feedback_reports(report)
	Dir.mkdir("feedback") unless Dir.exists?("feedback")

	hours_report = "feedback/Feedback_Report.html"

	File.open(hours_report, 'w') do |file|
		file.puts report
	end
end

def save_thank_you_letter(id, form_letter)
	Dir.mkdir("output") unless Dir.exists?("output")

	filename = "output/thanks_#{id}.html"

	File.open(filename, 'w') do |file|
		file.puts form_letter
	end
end

puts "EventManager Initialized."

contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter
hours_letter = File.read "hours_layout.erb"
erb_template_feedback = ERB.new hours_letter
reg_date_array = []

contents.each do |row|
	id = row[0]
	name = row[:first_name]	
	zipcode = clean_zipcode(row[:zipcode])
	phone = clean_phone(row[:homephone])
	legislators = legislators_by_zipcode(zipcode)	
	reg_date_array << reg_date_time(row[:regdate])	
	form_letter = erb_template.result(binding)
	save_thank_you_letter(id, form_letter)
end

fb_hours_array = feedback_report_hours(reg_date_array)
fb_day_array = feedback_report_day(reg_date_array)
feedback_page = erb_template_feedback.result(binding)
save_feedback_reports(feedback_page)	






