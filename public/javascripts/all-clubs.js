// CODE WILL BE USED FOR DYNAMIC CONTENT

// Get a reference to the grid container element
var gridContainer = document.getElementById('grid-container');

// Create an array of items to populate the grid
var items = [
  'Item 1',
  'Item 2',
  'Item 3',
  'Item 4',
  'Item 5',
  'Item 6',
  'Item 7',
  'Item 8',
  'Item 9'
];

// Iterate over the items and create div elements for each
items.forEach( item => {
    const div = document.createElement('div');
    div.classList.add('item');
    div.textContent = item;
    gridContainer.appendChild(div);
  });