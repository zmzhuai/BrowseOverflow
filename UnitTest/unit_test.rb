cmd = "xcodebuild -scheme BrowseOverflowTests -sdk iphonesimulator clean build RUN_UNIT_TEST_WITH_IOS_SIM=YES"
system(cmd)

result = ""
File.open("./UnitTest/unit_test.log", "r") do |f|
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

