import * as PIXI from 'pixi.js';

export const initialize = (element) => {
  const app = {
    pixi: undefined,
    data: undefined,
  }

  app.pixi = new PIXI.Application({ width: 360, height: 360, backgroundAlpha: 0 });
  element.appendChild(app.pixi.view);

  const container = new PIXI.Container();

  app.pixi.stage.addChild(container);

  // Listen for animate update
  app.pixi.ticker.add(update.bind(app));

  return app;
}

export const destroy = (app, element) => {
  app.data = undefined;

  if (!app.pixi) return
  element.removeChild(app.pixi.view);
  app.pixi.destroy(true, true);
  app.pixi = undefined;
}

/**
 * Set graph data
 *
 * @param {*} data The graph data.
 */
export const setData = (app, data) => {
  app.data = data;
  return app;
}

const update = function (delta) {
  const app = this;
}
