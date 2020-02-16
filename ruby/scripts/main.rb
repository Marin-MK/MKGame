# Starts the main game loop required to keep the game running.

map = MKD::Map.fetch(1)
map.encounter_tables = [
  EncounterTable.new do
    @density = 0.25
    @list = [
      [5, {species: :BULBASAUR, level: 1}],
      [4, {species: :BULBASAUR, level: 2}],
      [3, {species: :BULBASAUR, level: 3}],
      [2, {species: :BULBASAUR, level: 4}],
      [1, {species: :BULBASAUR, level: 5}]
    ]
    @tiles = [
      [0, 6],
      [0, 7], [1, 7],
      [0, 8], [1, 8], [2, 8],
      [0, 9], [1, 9], [2, 9], [3, 9],
      [0, 10], [1, 10], [2, 10], [3, 10], [4, 10], [5, 10],
      [0, 11], [1, 11], [2, 11], [3, 11], [4, 11], [5, 11],
      [0, 12], [1, 12], [2, 12], [3, 12], [4, 12], [5, 12], [6, 12],
      [0, 13], [1, 13], [2, 13], [3, 13], [4, 13], [5, 13], [6, 13], [7, 13],
      [0, 14], [1, 14], [2, 14], [3, 14], [4, 14], [5, 14], [6, 14], [7, 14]
    ]
  end
]
w = map.width
map.autotiles = [2, 3]
map.tiles[1][17] = [1, 0, 34]
map.tiles[1][18] = [1, 0, 20]
map.tiles[1][19] = [1, 0, 36]
map.tiles[1][32] = [1, 0, 40]
map.tiles[1][33] = [1, 0, 28]
map.tiles[1][34] = [1, 0, 38]

map.tiles[1][2] = [1, 1, 0]
map.save

# Initializes the game
$LOG = {
  WARNING: true,
  SYSTEM: true,
  OVERWORLD: false,
  UI: false
}
$temp = TempData.new
$visuals = Visuals.new
$game = Game.new
$game.switches = Game::Switches.new
$game.variables = Game::Variables.new
$game.player = Game::Player.new(1)
$game.player.setup_visuals
$game.load_map(1)
$visuals.map_renderer.create_tiles if $visuals.map_renderer.empty?
$trainer = Trainer.new

$trainer.add_pokemon(Pokemon.new(:BULBASAUR, 100, gender: 1, item: :REPEL, hp: 37))
$trainer.add_pokemon((p=Pokemon.new(:BULBASAUR, 32);p.exp+=2000;p))
$trainer.add_pokemon(Pokemon.new(:BULBASAUR, 3, gender: 1, status: :PARALYSIS, hp: 13))
$trainer.add_pokemon(Pokemon.new(:BULBASAUR, 4, item: :REPEL))
$trainer.add_pokemon(Pokemon.new(:BULBASAUR, 5, hp: 6, status: :POISON))
$trainer.add_pokemon(Pokemon.new(:BULBASAUR, 6, gender: 1, hp: 0))

$trainer.add_item(:MAXREPEL, 5)

def main_function
  $game.update
  $visuals.update
  if Input.trigger?(Input::CTRL)
    abort
  end
  if Input.trigger?(Input::SHIFT)
    p "test"
  end
end

loop do
  Input.update
  Graphics.update
  main_function
end
