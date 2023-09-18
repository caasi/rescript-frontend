/**
 * It compares an entry array with an entry map and returns the differences.
 *
 * @param {*} xs The new entry array.
 * @param {*} itemMap The existing entry map.
 * @returns An object containing the differences. The object has three
 *          lists: existed, added, and removed.
 */
export const diff = (xs, itemMap) => {
  const newMap = new Map();
  const existed = [];
  const added = [];
  const removed = [];
  for (const x of xs) {
    if (itemMap.has(x.id)) {
      existed.push(x);
    } else {
      added.push(x);
    }
    newMap.set(x.id, true);
  }
  for (const id of itemMap.keys()) {
    if (!newMap.has(id)) {
      removed.push(itemMap.get(id));
    }
  }
  return { existed, added, removed };
}
