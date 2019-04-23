# The X and Y buttons don't actually do anything.
# The physical Z key is used for SELECT.
# The physical V key is used for START.
# As it's not possible to add buttons in the F1 controls config,
# it uses the existing (unused) X and Y buttons for SELECT and START.
# This allows you to do Input::START and Input::SELECT.
module Input
  START = V
  SELECT = Z
end

class << Input
  INITIAL_REPEAT_COOLDOWN = 0.5
  CONTINUOUS_REPEAT_COOLDOWN = 0.075

  # @return [Integer] one of the 8 directions based on the arrow keys.
  def dir8
    l = Input.press?(Input::LEFT)
    r = Input.press?(Input::RIGHT)
    d = Input.press?(Input::DOWN)
    u = Input.press?(Input::UP)
    l = r = false if r && l
    d = u = false if u && d
    return 1 if l && d
    return 3 if d && r
    return 9 if r && u
    return 7 if u && l
    return 4 if l
    return 2 if d
    return 6 if r
    return 8 if u
    return 0
  end

  # @return [Integer] one of the 4 directions based on the arrow keys.
  def dir4
    l = Input.press?(Input::LEFT)
    r = Input.press?(Input::RIGHT)
    d = Input.press?(Input::DOWN)
    u = Input.press?(Input::UP)
    l = r = false if r && l
    d = u = false if u && d
    return 2 if d
    return 8 if u
    return 6 if r
    return 4 if l
    return 0
  end


  # @return [Boolean] whether the confirm button is triggered.
  def confirm?
    return Input.trigger?(Input::C)
  end

  # @return [Boolean] whether the confirm button is being held down.
  def repeat_confirm?(initial = INITIAL_REPEAT_COOLDOWN, continuous = CONTINUOUS_REPEAT_COOLDOWN)
    return Input.repeat?(Input::C, initial, continuous)
  end

  # @return [Boolean] whether the confirm button is constantly held down.
  def press_confirm?
    return Input.press?(Input::C)
  end

  # @return [Boolean] whether the cancel button is triggered.
  def cancel?
    return Input.trigger?(Input::X)
  end

  # @return [Boolean] whether the cancel button is being held down.
  def repeat_cancel?(initial = INITIAL_REPEAT_COOLDOWN, continuous = CONTINUOUS_REPEAT_COOLDOWN)
    return Input.repeat?(Input::X, initial, continuous)
  end

  # @return [Boolean] whether the cancel button is constantly held down.
  def press_cancel?
    return Input.press?(Input::X)
  end

  # @return [Boolean] whether the down button is triggered.
  def down?
    return Input.trigger?(Input::DOWN)
  end

  # @return [Boolean] whether the down button is being held down.
  def repeat_down?(initial = INITIAL_REPEAT_COOLDOWN, continuous = CONTINUOUS_REPEAT_COOLDOWN)
    return Input.repeat?(Input::DOWN, initial, continuous)
  end

  # @return [Boolean] whether the left button is triggered.
  def left?
    return Input.trigger?(Input::LEFT)
  end

  # @return [Boolean] whether the left button is being held down.
  def repeat_left?(initial = INITIAL_REPEAT_COOLDOWN, continuous = CONTINUOUS_REPEAT_COOLDOWN)
    return Input.repeat?(Input::LEFT, initial, continuous)
  end

  # @return [Boolean] whether the right button is triggered.
  def right?
    return Input.trigger?(Input::RIGHT)
  end

  # @return [Boolean] whether the right button is being held down.
  def repeat_right?(initial = INITIAL_REPEAT_COOLDOWN, continuous = CONTINUOUS_REPEAT_COOLDOWN)
    return Input.repeat?(Input::RIGHT, initial, continuous)
  end

  # @return [Boolean] whether the up button is triggered.
  def up?
    return Input.trigger?(Input::UP)
  end

  # @return [Boolean] whether the up button is being held down.
  def repeat_up?(initial = INITIAL_REPEAT_COOLDOWN, continuous = CONTINUOUS_REPEAT_COOLDOWN)
    return Input.repeat?(Input::UP, initial, continuous)
  end

  # @return [Boolean] whether the start button is triggered.
  def start?
    return Input.trigger?(Input::START)
  end

  # @return [Boolean] whether or not the button is being held down.
  def repeat?(button, initial = INITIAL_REPEAT_COOLDOWN, continuous = CONTINUOUS_REPEAT_COOLDOWN)
    @repeating ||= {}
    if Input.trigger?(button)
      @repeating[button] = [false, 0]
      return true
    elsif Input.press?(button) && @repeating[button]
      if @repeating[button][0] # Initial press has been returned
        if @repeating[button][1] == framecount(continuous)
          @repeating[button][1] = 0
          return true
        end
        return false
      else # Otherwise
        if @repeating[button][1] == framecount(initial)
          @repeating[button][1] = 0
          @repeating[button][0] = true # Mark initial press as having been returned
          return true
        end
        return false
      end
    else
      @repeating.delete(button)
      return false
    end
  end

  alias old_input_update update
  def update
    old_input_update
    @repeating ||= {}
    @repeating.keys.each do |key|
      if Input.press?(key)
        @repeating[key][1] += 1
      else
        @repeating.delete(key)
      end
    end
  end
end
