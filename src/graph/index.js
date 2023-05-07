import * as PIXI from 'pixi.js';
import logo from './logo.png';

let app;

export const initialize = (element) => {
  if (app) return;

  app = new PIXI.Application({ width: 360, height: 360, backgroundAlpha: 0 });
  element.appendChild(app.view);

  const container = new PIXI.Container();

  app.stage.addChild(container);

  // Create a new texture
  const texture = PIXI.Texture.from(logo);

  // Create a logo
  const sprite = new PIXI.Sprite(texture);
  sprite.anchor.set(0.5);
  sprite.scale.set(0.5);
  sprite.x = 0;
  sprite.y = 0;
  container.addChild(sprite);

  // Move container to the center
  container.x = app.screen.width / 2;
  container.y = app.screen.height / 2;

  // Center bunny sprite in local container coordinates
  container.pivot.x = container.width / 2;
  container.pivot.y = container.height / 2;

  // Listen for animate update
  app.ticker.add((delta) => {
    // rotate the container!
    // use delta to create frame-independent transform
    container.rotation -= 0.01 * delta;
  });
}

export const destroy = (element) => {
  if (!app) return

  app.destroy(true, true);
  app = undefined;
}
