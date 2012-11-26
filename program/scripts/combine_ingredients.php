#!/usr/bin/php
<?php
require '/home/www/GOTUN/PeanutCMS/lib/bootstrap.php';
Lib::import('Database.*');
Lib::import('Database.Drivers.PdoMysqlDatabase');

$db = new PdoMysqlDatabase(array(
  'database' => 'foodl',
  'server' => 'server1.apakoh.dk',
  'username' => 'foodl',
  'password' => 'foodl4321',
));

//SELECT *, COUNT(*) AS dup_count, SUM(quantity) AS quantity_sum FROM ingredients GROUP BY name, recipe_id, unit ORDER BY dup_count DESC
$result = $db->ingredients->select()
  ->addColumn('*')
  ->addColumn('*', 'dup_count', 'COUNT()')
  ->addColumn('quantity', 'quantity_sum', 'SUM()')
  ->groupBy(array('name', 'recipe_id', 'unit'))
  ->orderByDescending('dup_count')
  ->execute();

while ($assoc = $result->fetchAssoc()) {
  echo 'SELECT ' . $assoc['id'] . ' ';
  echo 'DUPS ' . $assoc['dup_count'] . ' ';
  if ($assoc['dup_count'] > 1) {
    //DELETE FROM ingredients WHERE name = ? AND recipe_id = ? AND unit = ? AND id != ?
    $db->ingredients->delete()
      ->where('name = ?', $assoc['name'])
      ->and('recipe_id = ?', $assoc['recipe_id'])
      ->and('unit = ?', $assoc['unit'])
      ->and('id != ?', $assoc['id'])
      ->execute();
    echo 'DELETE ';
    //UPDATE ingredients SET quantity = ? WHERE id = ?
    $db->ingredients->update()
      ->set('quantity', $assoc['quantity_sum'])
      ->where('id = ?', $assoc['id'])
      ->execute();
    echo 'UPDATE' . PHP_EOL;
  }
}
