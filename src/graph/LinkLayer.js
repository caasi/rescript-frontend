import { Container } from 'pixi.js';
import * as Entry from './entry';
import Link from './Link';

export default class LinkLayer extends Container {
  constructor() {
    super();
    this.__nodes = undefined;
    this.__nodeMap = new Map();
    this.__links = undefined;
    this.__linkMap = new Map();
  }

  destroy() {
    for (const n of this.__linkMap.values()) {
      this.__linkMap.delete(n.id);
      n.destroy();
      this.removeChild(n);
    }
    this.__linkMap = undefined;
    this.__links = undefined;
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
      this.__nodeMap.set(n.id, n);
    }
    for (const n of added) {
      this.__nodeMap.set(n.id, n);
    }
    for (const n of removed) {
      this.__nodeMap.delete(n.id);
    }
  }

  get links() {
    return this.__links;
  }

  set links(links) {
    if (!links) {
      this.__nodes = undefined;
      return
    }

    this.__links = links;
    const { existed, added, removed } = Entry.diff(this.__links, this.__linkMap);

    for (const l of existed) {
      const link = this.__linkMap.get(l.id);
      if (!link) continue;
      const srcNode = this.__nodeMap.get(l.src);
      const dstNode = this.__nodeMap.get(l.dst);
      if (!srcNode || !dstNode) continue;
      link.start = srcNode;
      link.end = dstNode;
    }
    for (const l of added) {
      const srcNode = this.__nodeMap.get(l.src);
      const dstNode = this.__nodeMap.get(l.dst);
      if (!srcNode || !dstNode) continue;
      const link = new Link();
      link.start = srcNode;
      link.end = dstNode;
      this.addChild(link);
      this.__linkMap.set(l.id, link);
    }
    for (const l of removed) {
      const link = this.__linkMap.get(l.id);
      if (!link) continue;
      this.__linkMap.delete(link);
      this.removeChild(link);
    }
  }
}
