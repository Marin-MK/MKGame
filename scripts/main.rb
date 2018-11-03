=begin

START
$game is initialized
$game.map is initialized and in turn initializes $visuals.map
$game.player is initialized and in turn initializes $visuals.player

LOOP
$game is updated
$game.map is updated
$game.player is updated
$visuals is updated
$visuals.maps are updated
$visuals.player is updated

=end

loop do
  Graphics.update
  Input.update
  $game.update
  $visuals.update
  if Input.press?(Input::CTRL)
    abort
  end
end