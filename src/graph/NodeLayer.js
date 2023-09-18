import { Container } from 'pixi.js';
import * as Entry from './entry';
import Node from './Node';

export default class NodeLayer extends Container {
  constructor() {
    super();
    this.__nodes = undefined;
    this.__nodeMap = new Map();
  }

  destroy() {
    for (const n of this.__nodeMap.values()) {
      this.__nodeMap.delete(n.id);
      n.destroy();
      this.removeChild(n);
    }
    this.__nodeMap = undefined;
    this.__nodes = undefined;
    super.destroy();
  }

  get nodes() {
    return this.__nodes;
  }

  set nodes(nodes) {
    if (!nodes) {
      this.__nodes = undefined;
      return
    }

    this.__nodes = nodes;
    const { existed, added, removed } = Entry.diff(this.__nodes, this.__nodeMap);

    for (const n of existed) {
      const node = this.__nodeMap.get(n.id);
      node.x = n.x;
      node.y = n.y;
    }
    for (const n of added) {
      const node = new Node();
      node.x = n.x;
      node.y = n.y;
      this.addChild(node);
      this.__nodeMap.set(n.id, node);
    }
    for (const n of removed) {
      const node = this.__nodeMap.get(n.id);
      this.__nodeMap.delete(node);
      this.removeChild(node);
    }
  }
}
