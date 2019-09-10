us_states = %w(Alabama 
Alaska 
Arizona 
Arkansas 
California 
Colorado 
Connecticut 
Delaware 
Florida 
Georgia 
Hawaii 
Idaho 
Illinois
Indiana 
Iowa 
Kansas 
Kentucky 
Louisiana 
Maine 
Maryland 
Massachusetts 
Michigan 
Minnesota 
Mississippi 
Missouri 
Montana
Nebraska 
Nevada 
New\ Hampshire 
New\ Jersey 
New\ Mexico 
New\ York 
North\ Carolina 
North\ Dakota 
Ohio 
Oklahoma 
Oregon 
Pennsylvania
Rhode\ Island 
South\ Carolina 
South\ Dakota 
Tennessee 
Texas 
Utah 
Vermont 
Virginia 
Washington 
West\ Virginia 
Wisconsin 
Wyoming)

US_STATES = us_states.map(&:upcase!)

US_STATES.each do |s|
	puts s
end

raise

total_words = 0
special_words = 0
state_counts = Hash.new(0)

one_match_words = {}
File.open("/usr/share/dict/words") do |entire|
	entire.each do |line|
		total_words += 1
		special_state = nil
		word = line.strip.gsub(/[^A-Za-z.]/, '').upcase
		US_STATES.each do |state_name|
			if state_name.count(word) == 0
				if special_state.nil?
					# this is the first missed state, record it
					special_state = state_name
				else
					# you only get here if you miss 2 states
					# thus the word is boring
					special_state = nil
					break
				end
			end
		end
		# if exactly one match
		unless special_state.nil?
			one_match_words[word] = special_state
			special_words += 1
			state_counts[special_state] += 1
		end
	end
end

puts special_words/(total_words + 0.0)

state_counts.each do |k, v|
	puts "#{k}\t #{v}"
end

# one_match_words.each do |k, v|
# 	puts "#{k.downcase}, #{v.downcase}"
# end