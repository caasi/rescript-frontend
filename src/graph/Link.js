import { Container, Graphics } from 'pixi.js';
import * as M from 'mathjs';

export default class Link extends Container {
  constructor() {
    super();

    // initial start point and end point
    this.__start = { x: 0, y: 0 };
    this.__end = { x: 0, y: 0 };

    this.__line = new Graphics();
    this.addChild(this.__line);
    this.__draw();
  }

  destroy() {
    this.removeChild(this.__circle);
    this.__line.destroy();
    this.__line = undefined;
    super.destroy();
  }

  get start() {
    return this.__start;
  }

  set start(value) {
    if (!M.isNumeric(value?.x) || !M.isNumeric(value?.y)) {
      throw new Error('start point must be point data');
    }
    this.__start = value;
    this.__draw();
  }

  get end() {
    return this.__end;
  }

  set end(value) {
    if (!M.isNumeric(value?.x) || !M.isNumeric(value?.y)) {
      throw new Error('end point must be point data');
    }
    this.__end = value;
    this.__draw();
  }

  __draw() {
    const s = this.__start;
    const e = this.__end;

    if (!this.start || !this.end) return;
    if (M.equal(s.x, e.x) && M.equal(s.y, e.y)) return;

    const g = this.__line;
    g.clear();
    g.moveTo(s.x, s.y);
    g.lineStyle(1, 0x2ecc71, 1);
    g.lineTo(e.x, e.y);
    g.endFill();
  }
}
