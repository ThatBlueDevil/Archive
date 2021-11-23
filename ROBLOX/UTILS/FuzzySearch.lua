--[[
  @file FuzzySearch
  @author https://devforum.roblox.com/u/regularwolf/summary
--]]
return function(ComparisonStrings, SearchString)
	local SearchResults = {}
	
	for _,ComparisonString in pairs(ComparisonStrings) do
		local ComparisonStringLength = #ComparisonString
		local SearchStringLength = #SearchString
		
		if SearchStringLength <= ComparisonStringLength + 5 then
			
			local TempComparisonString = ComparisonString:lower()
			local TempSearchString = SearchString:lower()
			
			local Cost
			
			local Rows = ComparisonStringLength  + 1
			local Columns = SearchStringLength + 1
			
			local Distance = {}
		
			for i = 1, Rows do
				Distance[i] = {}
				
				for k = 1, Columns do
					Distance[i][k] = 0
				end
			end
			
			for i = 2, Rows do
				for k = 2, Columns do
					Distance[i][1] = i
					Distance[1][k] = k
				end
			end
			
			for i = 2, Columns do
				for k = 2, Rows do
					if TempComparisonString:sub(k - 1, k - 1) == TempSearchString:sub(i - 1, i - 1) then
						Cost = 0
					else
						Cost = 2
					end
					
					Distance[k][i] = math.min(
						Distance[k - 1][i] + 1,
						Distance[k][i - 1] + 1,
						Distance[k - 1][i - 1] + Cost
					)
				end
			end
			
			table.insert(SearchResults, 
				{
					Ratio = ((ComparisonStringLength + SearchStringLength) - Distance[Rows][Columns]) / (ComparisonStringLength + SearchStringLength),
					Word = ComparisonString
				}
			)
		else
			table.insert(SearchResults,
				{
					Ratio = 0,
					Word = ComparisonString
				}
			)
		end
	end
	
	table.sort(SearchResults, function(A, B)
		return A.Ratio > B.Ratio
	end)
	
	return SearchResults
end
