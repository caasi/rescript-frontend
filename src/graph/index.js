import * as PIXI from 'pixi.js';
import NodeLayer from './NodeLayer';
import LinkLayer from './LinkLayer';

export const initialize = (element) => {
  const app = {
    pixi: undefined,
    data: undefined,
    nodeLayer: undefined,
    linkLayer: undefined,
  }

  app.pixi = new PIXI.Application({ width: 360, height: 360, backgroundAlpha: 0 });
  element.appendChild(app.pixi.view);

  const container = new PIXI.Container();
  app.pixi.stage.addChild(container);

  app.nodeLayer = new NodeLayer();
  app.pixi.stage.addChild(app.nodeLayer);
  app.linkLayer = new LinkLayer();
  app.pixi.stage.addChild(app.linkLayer);

  app.pixi.stage.addEventListener('click', handleClick.bind(app));

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

export const resize = (app, width, height) => {
  if (!app.pixi) return app
  app.pixi.renderer.resize(width, height);
  return app
}

/**
 * Set graph data
 *
 * @param {*} data The graph data.
 */
export const setData = (app, data) => {
  app.data = data;
  if (app.nodeLayer) app.nodeLayer.nodes = data.nodes;
  if (app.linkLayer) {
    app.linkLayer.nodes = data.nodes;
    app.linkLayer.links = data.links;
  }
  return app;
}

const handleClick = function (event) {
  console.log('click')
  const app = this;
}

const update = function (delta) {
  const app = this;
}
