pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
function _init()
p={x=60,y=90,speed=4}	
bullets={}
enemies={}
explosions={} 
spawn_enemies()
create_explosions(63,63)
score=0

end

function _update60()
if (btn(➡️)) p.x+=1
if (btn(⬅️)) p.x-=1
if (btn(⬆️))	p.y-=1
if (btn(⬇️)) p.y+=1
if (btnp(❎)) shoot()
update_bullets() 


p.x =mid(0,120,p.x)
p.y =mid(0,120,p.y)

if #enemies==0 then 
	spawn_enemies()
end  
update_enemies()
update_explosions()
end

function _draw()
cls(1)
map(0,0,0,0,16,16)
draw_map()
--vaisseau
spr(1,p.x,p.y)	
--ennemies
for e in all(enemies) do
	spr(3,e.x,e.y)
end
	--explosion
draw_explosions()
--bullets
for b in all(bullets) do
	spr(2,b.x,b.y)
end
	--score
	print(score_text(),0,15,7)
	print("score:",2,2,7)
	print(score,2,8)
end






-->8
--bullets
function shoot()
 new_bullet={
 x=p.x,
 y=p.y,
 speed=4
 }
 add(bullets,new_bullet)	
 sfx(0) 
end
 
function update_bullets() 
	for b in all(bullets) do
		b.y-=b.speed 
	end
end
-->8
 --enemies
 
function spawn_enemies()
enemies={}
 for i=1,20 do
 new_enemy={
 	x=rnd(128),
 	y=rnd(55),
 	life=1,
 	speed=0.1
 }
 	 add(enemies,new_enemy)
end
 end

function update_enemies()
	for e in all(enemies) do
		e.y+=0.3
		if e.y >128 then 
			del(enemies,e)
		end
	--collision
	for b in all (bullets) do
		if collision(e,b) then
 			create_explosions(b.x,b.y)
			del(bullets,b)
			e.life -=1
			if e.life==0 then
				del(enemies,e)
				score+=1
			if score ==50 then
				sfx(2)
			end	
			end
		end
	end
end
end
	
-->8
--collision

function collision(a,b)
	if a.x > b.x+8
	or a.y > b.y+8
	or a.x+8 <b.x
	or a.y+8 <b.y then
		return false
		else
			return true
		end
	end

-->8
 --map

function draw_map()
	map(0,0,0,0,128,64)

end


-->8
--explosion


function create_explosions(_x,_y)
	sfx(1) 
	add(explosions,{x=_x,
	                y=_y,
	                timer=0})
end

function update_explosions()
	for e in all(explosions) do
		e.timer+=1
		if e.timer==13 then
			del(explosions,e)
		end
	end
end

function draw_explosions()
	--circ(x,y,rayon,coouleur)
	
	for e in all(explosions) do
		circ(e.x,e.y,e.timer/3,
		     8+e.timer%3)
	end
end
-->8
--score

function score_text()
	if score >= 50 then
		  return "super score!!!"
	else
	   return "tu peux mieux faire:("	
		
	end
end


__gfx__
00000000000000000000000008000800bbbbbbbbbbbffbbbbbbbbbbb00000000b3bb3bbbbbbbbbbbbbbffbbbbbbffbbb08000800000000000000000000000000
00000000b0000b000900009080000080bbb8bbbbbbbffbbbabbbbbbb000ff000bb33bbbbbbb88bbbbbbffbbbbbbffbbb80000080000000000000000000000000
00700700b0000b000000000080808080bb989bbbbb9999bbbbbbbbbb00999900b8888bbbbb9999bbbb9999bbbb8888bb80808080000000000000000000000000
000770002b00b2600000000088000880b99999bbb879998bbbbbbabb08799980888888bbff9999ffb89999ffbb8888bb88000880000000000000000000000000
000770002b00b26000000000807070809909099bb899998bbbbbbbbb08999980888888bbff9999ffb89999ffbbb88bbb80707080000000000000000000000000
00700700bbbbbb200a0000a0887878809999999bbb9999bbbbbbbbbb00999900b8888bbbbb9799bbbb9799bbbbb88bbb88787880000000000000000000000000
00000000bbbbbbb00a0000a008888800b99999bbbbbffbbbbbabbbbb000ff000bb88bbbbbbb88bbbbbb88bbbbbb88bbb08888800000000000000000000000000
000000000b00b0200900009080808080bb999bbbbbbffbbbbbbbbbbb00000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb80808080000000000000000000000000
cccccccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
cccccccc000000000000000000000000000ff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
cccccccc000000000000000000000000009999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
cccccccc000000000000000000000000087999800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
cccccccc000000000000000000000000089999800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
cccccccc000000000000000000000000009999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
cccccccc000000000000000000000000000ff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
cccccccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
000000000000000000000000000000000d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
00010000000002105021050215501f05016050120500e040090300602000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001000036670356703467032670306502e6402c640296302763024650226501f6501d6501a650186501565013650106500d6500b650086500565004650016500065000650006500065000650006500065000000
001400001f7501b0501805016050170501905019050190501705016750170501705016050120500f0500075000730000100000000000000000000000000000000000000000000000000000000000000000000000
