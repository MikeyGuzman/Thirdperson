if SERVER then return end
local FirstPressed = {}

hook.Add( "Think", "CallBindings", function()
		local cache = input.IsButtonDown( KEY_T )
		if cache and FirstPressed[ KEY_T ] then
			ThirdPersonUmsg()
		end
		FirstPressed[ KEY_T ] = not cache
end )

function ThirdPersonUmsg()
    if( LocalPlayer().ThirdPerson == nil ) then
        LocalPlayer().ThirdPerson = true;
    else
        LocalPlayer().ThirdPerson = !LocalPlayer().ThirdPerson;
    end;	
end;

function ThirdPerson( ply, pos, angles, fov )
    if( LocalPlayer().ThirdPerson ) then
    local view = {};
    local dist = 100;
    local trace = util.TraceHull( {
        start = pos,
        endpos = pos - angles:Forward() * 100,
        filter = { ply:GetActiveWeapon(), ply },
        mins = Vector( -4, -4, -4 ),
        maxs = Vector( 4, 4, 4 ),
    } )

    if ( trace.Hit ) then
    
        pos = trace.HitPos
    
    else pos = pos - angles:Forward() * 100
    
    end

    return {
        origin = pos,
        angles = angles,
        drawviewer = true
    }
    end;
end;
hook.Add( "CalcView", "ThirdPerson", ThirdPerson );

function ThirdPersonSDLP()
    if( LocalPlayer().ThirdPerson ) then
        return true;
    end;
end;
hook.Add( "ShouldDrawLocalPlayer", "ThirdPersonSDLP", ThirdPersonSDLP );
