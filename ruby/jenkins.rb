cmd = "xcodebuild -target BrowseOverflowTests -sdk iphonesimulator RUN_UNIT_TEST_WITH_IOS_SIM=YES clean build > ./ruby/buildlog.txt 2> ./ruby/testlog.txt"
system(cmd)

result = ""
File.open("./ruby/buildlog.txt", "r") do |f|
	result = f.read
end

fails = result.scan /Test Case .* failed/
passes = result.scan /Test Case .* passed/

if fails.length>0
	puts fails
	raise "Unit Tests failed"
else
	if passes.length>0
		puts "Unit Tests passed"
	else
		puts result
		raise "Unit Test setup problem"
	end
end

