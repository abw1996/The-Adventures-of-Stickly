#!usr/bin/env ruby
require 'gosu'
#physics constants
GRAVITY = 800/60
GRAVACCEL = 1.006
FLOOR = 2638 * 2.5
#stickly struct for sticklys location etc
SticklyState = Struct.new(
	:stickly_x,
	:stickly_y,
	:stickly_vel,
	:speed_accel,
	:stickly_left,
)

BulletState = Struct.new(
	:bullet_x,
	:bullet_y,
	:bullet_vel,
	:bullet_exist,
)
$level_one_hash = {
	floor_hash: {
		floor: [0 , 1400 , 0],
		floor2: [FLOOR , 1400 , 0],
		floor3: [FLOOR*2 + 300 , 1400 , 0],
		floor4: [FLOOR*3 + 300 , 1400 , 0],
	   	floor5: [FLOOR*4 + 300 , 1400 , 0],
		floor6: [FLOOR*5 + 300 , 1400 , 0],
		floor7: [FLOOR*6 + 900 , 1400 , 0],
		floor8: [FLOOR*7 + 900 , 1400 , 0],
		floor9: [FLOOR*8 + 900 , 1400 , 0],
		floor10: [FLOOR*9 + 900 , 1400 , 0],
		floor11: [FLOOR*10 + 900 , 1400 , 0],
		floor12: [FLOOR*11 + 900 , 1400 , 0],
		floor13: [FLOOR*12 + 1500 , 1400 , 0],
		floor14: [FLOOR*13 + 2100 , 1400 , 0],
		floor15: [FLOOR*14 + 2100 , 1400 , 0],
		floor16: [FLOOR*15 + 2100 , 1400 , 0],
		floor17: [FLOOR*16 + 2100 , 1400 , 0],
		floor18: [FLOOR*17 + 2100 , 1400 , 0],
		floor19: [FLOOR*18 + 2100 , 1400 , 0],
		floor20: [FLOOR*19 + 2100 , 1400 , 0]
	}, 
	small_wall_hash: {
		wall1: [1000, 850 , 0]
	},
	cube_hash: {
		cube1: [2000, 850 , 0]
	}, 
	spike_hash: {
		spike1: [4000, 850 , 0]
	},	
	wall_hash: {
		wall1: [5500, 850 , 0]
	}

		
}
class Game < Gosu::Window
	def initialize
		super 1840 , 1840 
		self.caption = "The Adventures Of Stickly"
#images for stickly game
		@background_image = Gosu::Image.new("/home/ashtonwilliams1996/rubyfiles/The_Adventures_Of_Stickly/background.png", :tileable => true);
		
		@stickly_image = Gosu::Image.new("/home/ashtonwilliams1996/rubyfiles/The_Adventures_Of_Stickly/Stickly.png", false);

		@stickly_left_image = Gosu::Image.new("/home/ashtonwilliams1996/rubyfiles/The_Adventures_Of_Stickly/Stickly_L.png", false);

		@stickly_bulletR = Gosu::Image.new("/home/ashtonwilliams1996/rubyfiles/The_Adventures_Of_Stickly/bullet_design.png" , false);

		@stickly_bulletL = Gosu::Image.new("/home/ashtonwilliams1996/rubyfiles/The_Adventures_Of_Stickly/bullet_designL.png" , false);

		@floor = Gosu::Image.new("/home/ashtonwilliams1996/rubyfiles/The_Adventures_Of_Stickly/floor.png", false);

		@spike = Gosu::Image.new("/home/ashtonwilliams1996/rubyfiles/The_Adventures_Of_Stickly/spike_floor.png", false);

		@wall = Gosu::Image.new("/home/ashtonwilliams1996/rubyfiles/The_Adventures_Of_Stickly/wall.png", false);

		@wall_small = Gosu::Image.new("/home/ashtonwilliams1996/rubyfiles/The_Adventures_Of_Stickly/wall_small.png", false);

		@cube = Gosu::Image.new("/home/ashtonwilliams1996/rubyfiles/The_Adventures_Of_Stickly/cube.png", false);

		@meth = Gosu::Image.new("/home/ashtonwilliams1996/rubyfiles/The_Adventures_Of_Stickly/meth.png", false);

		@stickly = SticklyState.new(200, 400 , 0 , GRAVACCEL , false);

		@bullet_R_one = BulletState.new(0 , 0 , 50 , false);
		@bullet_R_two = BulletState.new(0 , 0 , 50 , false);
		@bullet_R_three = BulletState.new(0 , 0 , 50 , false);
		@bullet_R_four = BulletState.new(0 , 0 , 50 , false);
		@bullet_R_five = BulletState.new(0 , 0 , 50 , false);

		@bullet_L_one = BulletState.new(0 , 0 , -50 , false);
		@bullet_L_two = BulletState.new(0 , 0 , -50 , false);
		@bullet_L_three = BulletState.new(0 , 0 , -50 , false);
		@bullet_L_four = BulletState.new(0 , 0 , -50 , false);
		@bullet_L_five = BulletState.new(0 , 0 , -50 , false);
	end
#jump key
	def button_down(button)
		if button == Gosu::KbSpace
			if @stickly.stickly_vel == 0
				if @stickly.stickly_y == 1100
					@stickly.stickly_y -= 1;
					@stickly.stickly_vel += -100;
				end

			end
       		end
		if button == Gosu::KbUp
			if @stickly.stickly_vel == 0
				if @stickly.stickly_y == 1100
					@stickly.stickly_y -= 1;
					@stickly.stickly_vel += -100;
				end
			end
		end
		if button == Gosu::KbEscape
			close!
		end
		if button == Gosu::KbS
			if @stickly.stickly_left
				if @bullet_L_one.bullet_exist == false
					@bullet_L_one.bullet_exist = true
					@bullet_L_one.bullet_x = @stickly.stickly_x - 50
					@bullet_L_one.bullet_y = @stickly.stickly_y + 160
				
				else
				       	if @bullet_L_two.bullet_exist == false
						@bullet_L_two.bullet_exist = true
						@bullet_L_two.bullet_x = @stickly.stickly_x - 50
						@bullet_L_two.bullet_y = @stickly.stickly_y + 160
					
					else 
						if @bullet_L_three.bullet_exist == false
							@bullet_L_three.bullet_exist = true
							@bullet_L_three.bullet_x = @stickly.stickly_x - 50
							@bullet_L_three.bullet_y = @stickly.stickly_y + 160
						else 
							if @bullet_L_four.bullet_exist == false
								@bullet_L_four.bullet_exist = true
								@bullet_L_four.bullet_x = @stickly.stickly_x - 50
								@bullet_L_four.bullet_y = @stickly.stickly_y + 160
							else 
								if @bullet_L_five.bullet_exist == false
									@bullet_L_five.bullet_exist = true
									@bullet_L_five.bullet_x = @stickly.stickly_x - 50
									@bullet_L_five.bullet_y = @stickly.stickly_y + 160
								end
							end
						end
					end
				end
			else 
				if @bullet_R_one.bullet_exist == false
					@bullet_R_one.bullet_exist = true
					@bullet_R_one.bullet_x = @stickly.stickly_x + 140
					@bullet_R_one.bullet_y = @stickly.stickly_y + 160
				else
					if @bullet_R_two.bullet_exist == false
						@bullet_R_two.bullet_exist = true
						@bullet_R_two.bullet_x = @stickly.stickly_x + 140
						@bullet_R_two.bullet_y = @stickly.stickly_y + 160
					else
						if @bullet_R_three.bullet_exist == false
							@bullet_R_three.bullet_exist = true
							@bullet_R_three.bullet_x = @stickly.stickly_x + 140
							@bullet_R_three.bullet_y = @stickly.stickly_y + 160
						else
							if @bullet_R_four.bullet_exist == false
								@bullet_R_four.bullet_exist = true
								@bullet_R_four.bullet_x = @stickly.stickly_x + 140
								@bullet_R_four.bullet_y = @stickly.stickly_y + 160
							else
								if @bullet_R_five.bullet_exist == false
									@bullet_R_five.bullet_exist = true
									@bullet_R_five.bullet_x = @stickly.stickly_x + 140
									@bullet_R_five.bullet_y = @stickly.stickly_y + 160
								end
							end
						end
					end
				end
			end
		end
	end

	def update 
#Gravity physics start
		if @stickly.stickly_y < 1100
			@stickly.stickly_vel += (GRAVITY * @stickly.speed_accel)/2;
			if @stickly.stickly_y < 1099
				@stickly.speed_accel = @stickly.speed_accel * @stickly.speed_accel
				if @stickly.stickly_vel < 60
					if @stickly.stickly_vel > -60
						@stickly.speed_accel = GRAVACCEL
					end
				end
			end
			@stickly.stickly_y += @stickly.stickly_vel;
		else
			@stickly.stickly_y = 1100;
			@stickly.stickly_vel = 0;
			@stickly.speed_accel = GRAVACCEL;
		end
#Gravity physics end
#Bullet physics start
		@bullet_R_one.bullet_x += @bullet_R_one.bullet_vel
		@bullet_R_two.bullet_x += @bullet_R_two.bullet_vel
		@bullet_R_three.bullet_x += @bullet_R_three.bullet_vel
		@bullet_R_four.bullet_x += @bullet_R_four.bullet_vel
		@bullet_R_five.bullet_x += @bullet_R_five.bullet_vel

		@bullet_L_one.bullet_x += @bullet_L_one.bullet_vel
		@bullet_L_two.bullet_x += @bullet_L_two.bullet_vel
		@bullet_L_three.bullet_x += @bullet_L_three.bullet_vel
		@bullet_L_four.bullet_x += @bullet_L_four.bullet_vel
		@bullet_L_five.bullet_x += @bullet_L_five.bullet_vel
		if @bullet_R_one.bullet_x > 1700
			@bullet_R_one.bullet_exist = false
		end
		if @bullet_R_two.bullet_x > 1700
			@bullet_R_two.bullet_exist = false
		end
		if @bullet_R_three.bullet_x > 1700
			@bullet_R_three.bullet_exist = false
		end
		if @bullet_R_four.bullet_x > 1700
			@bullet_R_four.bullet_exist = false
		end
		if @bullet_R_five.bullet_x > 1700
			@bullet_R_five.bullet_exist = false
		end
		if @bullet_L_one.bullet_x < -200
			@bullet_L_one.bullet_exist = false
		end
		if @bullet_L_two.bullet_x < -200
			@bullet_L_two.bullet_exist = false
		end
		if @bullet_L_three.bullet_x < -200
			@bullet_L_three.bullet_exist = false
		end
		if @bullet_L_four.bullet_x < -200
			@bullet_L_four.bullet_exist = false
		end
		if @bullet_L_five.bullet_x < -200
			@bullet_L_five.bullet_exist = false
		end

#Bullet physics end

#Left and right movements below
		if Gosu.button_down?(Gosu::KbRight) 
			if @stickly.stickly_x <= 800
				@stickly.stickly_x += 30
				@stickly.stickly_left = false
			else
				$level_one_hash.each do |object, arri|
					arri.each do |item, loca|
						loca[0] -= 30
					end
				end
			end
		end
		if Gosu.button_down?(Gosu::KbLeft) 
			if @stickly.stickly_x >= 100
				@stickly.stickly_x -= 30 
				@stickly.stickly_left = true
			else
				$level_one_hash.each do |object, arri|
					arri.each do |item, loca|
						loca[0]	+= 30
					end
				end	
			end
		end
	end

	def draw
		#God Damn IT stickly jump!!
		@background_image.draw(0 , 0 , 0)
		$level_one_hash.each do |object, arri|
			arri.each do |item, loca|
				if object == :floor_hash
					@floor.draw(loca[0] , loca[1] , loca[2] , scale_x = 2.5 , scale_y = 2.5)
				elsif object == :small_wall_hash
					@wall_small.draw(loca[0] , loca[1] , loca[2] , scale_x = 0.5 , scale_y = 0.5)
				elsif object == :cube_hash
					@cube.draw(loca[0] , loca[1] , loca[2] , scale_x = 0.5 , scale_y = 0.5)
				elsif object == :spike_hash
					@spike.draw(loca[0] , loca[1] , loca[2] , scale_x = 0.2 , scale_y = 0.2)
				elsif object == :wall_hash
					@wall.draw(loca[0] , loca[1] , loca[2] , scale_x = 0.5 , scale_y = 0.5)
				end
			end
			
		end		
		if @stickly.stickly_left == true
			@stickly_left_image.draw(@stickly.stickly_x , @stickly.stickly_y , 0 , scale_x = 0.15 , scale_y = 0.15)
		else @stickly_image.draw(@stickly.stickly_x , @stickly.stickly_y , 0 , scale_x = 0.15 , scale_y = 0.15) 
		end
		if @bullet_R_one.bullet_exist	
			@stickly_bulletR.draw(@bullet_R_one.bullet_x, @bullet_R_one.bullet_y, 0, scale_x = 0.03 , scale_y = 0.03)
		end
		if @bullet_R_two.bullet_exist
			@stickly_bulletR.draw(@bullet_R_two.bullet_x, @bullet_R_two.bullet_y, 0, scale_x = 0.03 , scale_y = 0.03)
		end
		if @bullet_R_three.bullet_exist
			@stickly_bulletR.draw(@bullet_R_three.bullet_x, @bullet_R_three.bullet_y, 0, scale_x = 0.03 , scale_y = 0.03)
		end
		if @bullet_R_four.bullet_exist
			@stickly_bulletR.draw(@bullet_R_four.bullet_x, @bullet_R_four.bullet_y, 0, scale_x = 0.03 , scale_y = 0.03)
		end
		if @bullet_R_five.bullet_exist
			@stickly_bulletR.draw(@bullet_R_five.bullet_x, @bullet_R_five.bullet_y, 0, scale_x = 0.03 , scale_y = 0.03)
		end
		if @bullet_L_one.bullet_exist
			@stickly_bulletL.draw(@bullet_L_one.bullet_x, @bullet_L_one.bullet_y, 0, scale_x = 0.03 , scale_y = 0.03)
		end
		if @bullet_L_two.bullet_exist
			@stickly_bulletL.draw(@bullet_L_two.bullet_x, @bullet_L_two.bullet_y, 0, scale_x = 0.03 , scale_y = 0.03)
		end
		if @bullet_L_three.bullet_exist
			@stickly_bulletL.draw(@bullet_L_three.bullet_x, @bullet_L_three.bullet_y, 0, scale_x = 0.03 , scale_y = 0.03)
		end
		if @bullet_L_four.bullet_exist
			@stickly_bulletL.draw(@bullet_L_four.bullet_x, @bullet_L_four.bullet_y, 0, scale_x = 0.03 , scale_y = 0.03)
		end
		if @bullet_L_five.bullet_exist
			@stickly_bulletL.draw(@bullet_L_five.bullet_x, @bullet_L_five.bullet_y, 0, scale_x = 0.03 , scale_y = 0.03)
		end
	end
end

Game.new.show

