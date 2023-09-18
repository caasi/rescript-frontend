import { Container, Graphics } from 'pixi.js';

export default class Node extends Container {
  constructor() {
    super();
    this.__circle = new Graphics();
    this.addChild(this.__circle);
    this.__draw();
  }

  destroy() {
    this.removeChild(this.__circle);
    this.__circle.destroy();
    this.__circle = undefined;
    super.destroy();
  }

  __draw() {
    const g = this.__circle;
    g.clear();
    g.beginFill(0x2ecc71);
    g.drawCircle(0, 0, 10);
    g.endFill();
  }
}
