getgenv().Target = ""; -- case sensitive.
local Client = game:GetService("Players").LocalPlayer;

HeartHook = nil; do
    HeartHook = hookmetamethod(game, "__namecall", function(Self, ...)
        local Method, Args = getnamecallmethod(), { ... };
        
        if (Method == "FireServer" and Self.Name == "Give") then
            if tostring(Args[1]) == getgenv().Target then
                for i = 1, Client.PlayerGui.Data.HeartsToGive.Value do HeartHook(Self, Args[1]) end;
            end;
        end;
        
        return HeartHook(Self, ...);
    end);
end;
